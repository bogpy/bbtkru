package repository

import (
	"fmt"
	"strings"

	"github.com/bogpy/bbtkru/internal/models"
	"github.com/jmoiron/sqlx"
)

type VacancyRepository struct {
	DB *sqlx.DB
}

func NewVacancyRepository(db *sqlx.DB) *VacancyRepository {
	return &VacancyRepository{DB: db}
}

func (r VacancyRepository) GetVacancies(request models.RequestForVacancy) ([]models.Vacancy, error) {
	var queryBuilder strings.Builder
	queryBuilder.WriteString("SELECT * FROM vacancy v WHERE 1=1")
	var args []interface{}
	fmt.Printf("Request for vacancies: %+v", request)
	if request.Experience != nil {
		queryBuilder.WriteString(" AND experience <= ?")
		args = append(args, *request.Experience)
	}

	if request.Salary != nil {
		queryBuilder.WriteString(" AND salary >= ?")
		args = append(args, *request.Salary)
	}

	if request.Employment != nil {
		queryBuilder.WriteString(" AND employment = ?")
		args = append(args, *request.Employment)
	}

	if request.Hours != nil {
		queryBuilder.WriteString(" AND hours <= ?")
		args = append(args, *request.Hours)
	}

	if request.Location != nil {
		queryBuilder.WriteString(" AND location = ?")
		args = append(args, *request.Location)
	}

	if request.Country != nil {
		queryBuilder.WriteString(" AND (SELECT c.country FROM company c WHERE c.id = v.compID) = ?")
		args = append(args, *request.Country)
	}

	query := queryBuilder.String()
	var vacancies []models.Vacancy
	fmt.Printf("Query: %s, args: %v", query, args)
	err := r.DB.Select(&vacancies, query, args...)
	if err != nil {
		return nil, err
	}
	fmt.Printf("Number of vacancies found: %v", len(vacancies))

	for i, vacancy := range vacancies {
		vacancies[i].Languages, err = r.GetLanguages(vacancy.ID)
		if err != nil {
			return nil, err
		}
		vacancies[i].Technologies, err = r.GetTechnologies(vacancy.ID)
		if err != nil {
			return nil, err
		}
	}

	return vacancies, nil
}

func (r VacancyRepository) BulkInsert(vacancies []*models.Vacancy) error {
	query := `INSERT INTO vacancy
		(title, description, companyID, experience, salary, hours, employment, location) 
		VALUES (:title, :description, :companyID, :experience, :salary, :hours, :employment, :location)`
	return NamedExecWrapper(r.DB, query, vacancies)
}

type VacancyLanguage struct {
	VacancyID  int64 `db:"vacancy_id"`
	LanguageID int64 `db:"language_id"`
}

type VacancyTechnology struct {
	VacancyID    int64 `db:"vacancy_id"`
	TechnologyID int64 `db:"technology_id"`
}

func (r VacancyRepository) InsertJunction(vacancies []*models.Vacancy, language_ids map[string]int64, technology_ids map[string]int64) error {
	query := `INSERT INTO vacancy_language
				 (vacancy_id, language_id)
					VALUES (:vacancy_id, :language_id)
				`
	var args1 []VacancyLanguage
	for _, vacancy := range vacancies {
		for _, language := range vacancy.GetLanguages() {
			languageID, ok := language_ids[language.Name]
			if !ok {
				return fmt.Errorf("id not found for language %v", language.Name)
			}
			args1 = append(args1, VacancyLanguage{vacancy.ID, languageID})
		}
	}
	tx := r.DB.MustBegin()
	_, err := tx.NamedExec(query, args1)
	if err != nil {
		tx.Rollback()
		return err
	}
	query = `INSERT INTO vacancy_technology
				(vacancy_id, technology_id)
				VALUES (:vacancy_id, :technology_id)
				`
	var args2 []VacancyTechnology
	for _, vacancy := range vacancies {
		for _, technology := range vacancy.GetTechnologies() {
			technologyID, ok := technology_ids[technology.Name]
			if !ok {
				return fmt.Errorf("id not found for technology %v", technology.Name)
			}
			args2 = append(args2, VacancyTechnology{vacancy.ID, technologyID})
		}
	}
	_, err = tx.NamedExec(query, args2)
	if err != nil {
		tx.Rollback()
		return err
	}
	tx.Commit()
	return nil
}

func (r VacancyRepository) GetLanguages(id int64) ([]models.Language, error) {
	query := `SELECT l.id, l.name
	 		  FROM language l
			  JOIN vacancy_language vl ON l.id = vl.language_id
			  WHERE vl.vacancy_id = ?
			  `
	var languages []models.Language
	err := r.DB.Select(&languages, query, id)
	if err != nil {
		return nil, err
	}
	return languages, err
}

func (r VacancyRepository) GetTechnologies(id int64) ([]models.Technology, error) {
	query := `SELECT t.id, t.name
	 		  FROM technology t
			  JOIN vacancy_technology vt ON t.id = vt.technology_id
			  WHERE vt.vacancy_id = ?
			  `
	var technologies []models.Technology
	err := r.DB.Select(&technologies, query, id)
	if err != nil {
		return nil, err
	}

	return technologies, nil
}

func (r VacancyRepository) GetVacancyByID(id int64) (*models.Vacancy, error) {
	var vacancy models.Vacancy
	var err error
	err = r.DB.Get(
		&vacancy,
		"SELECT * FROM vacancy WHERE (id) = (?)",
		id,
	)
	if err != nil {
		return nil, err
	}
	vacancy.Languages, err = r.GetLanguages(vacancy.ID)
	if err != nil {
		return nil, err
	}
	vacancy.Technologies, err = r.GetTechnologies(vacancy.ID)
	if err != nil {
		return nil, err
	}
	return &vacancy, nil
}

func (r VacancyRepository) InsertVacancy(v *models.Vacancy) error {
	query := `INSERT INTO vacancy
		(title, description, companyID, experience, salary, hours, employment, location) 
		VALUES (:title, :description, :companyID, :experience, :salary, :hours, :employment, :location)`

	res, err := r.DB.NamedExec(query, v)
	if err != nil {
		return err
	}
	id, err := res.LastInsertId()
	if err != nil {
		return fmt.Errorf("addVacancy: %v", err)
	}
	v.ID = id
	return nil
}

func (r VacancyRepository) DeleteVacancy(id int64) error {
	result, err := r.DB.Exec("DELETE FROM vacancy WHERE id = ?", id)
	if err != nil {
		return err
	}
	count, err := result.RowsAffected()
	if err != nil {
		return err
	}
	if count == 0 {
		return fmt.Errorf("Not found vacancy with id: %v", id)
	}

	return nil
}
