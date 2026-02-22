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

func NewVacancytRepository(db *sqlx.DB) *VacancyRepository {
	return &VacancyRepository{DB: db}
}

func (r VacancyRepository) getVacancies(request models.RequestForVacancy) ([]models.Vacancy, error) {
	var queryBuilder strings.Builder
	queryBuilder.WriteString("SELECT * FROM vacancy WHERE 1=1")
	var args []interface{}

	if request.Experience != nil {
		queryBuilder.WriteString("AND experience <= ?")
		args = append(args, *request.Experience)
	}

	if request.Salary != nil {
		queryBuilder.WriteString("AND salary >= ?")
		args = append(args, *request.Salary)
	}

	if request.Type != nil {
		queryBuilder.WriteString("AND type = ?")
		args = append(args, *request.Type)
	}

	if request.Hours != nil {
		queryBuilder.WriteString("AND hours <= ?")
		args = append(args, *request.Hours)
	}

	query := queryBuilder.String()
	var vacancies []models.Vacancy
	err := r.DB.Select(&vacancies, query, args...)
	if err != nil {
		return nil, err
	}

	// for _, vacancy := range vacancies {
	// 	err := vacancy.GetLanguages(db)
	// 	if err != nil {
	// 		return nil, err
	// 	}
	// 	err := vacancy.GetTechnologies(db)
	// 	if err != nil {
	// 		return nil, err
	// 	}
	// }

	return vacancies, nil
}

func (r VacancyRepository) BulkInsert(vacancies []*models.Vacancy) error {
	query := `INSERT INTO vacancy
		(title, description, companyID, experience, salary, hours, employment, location) 
		VALUES (:title, :description, :companyID, :experience, :salary, :hours, :employment, :location)`
	return NamedExecWrapper(r.DB, query, vacancies)
}

type VacancyLanguage struct {
	VacancyID int64 `db:"vacancy_id"`
	LanguageID int64 `db:"language_id"`
}

type VacancyTechnology struct {
	VacancyID int64 `db:"vacancy_id"`
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
	res, err := tx.NamedExec(query, args1)
	if err != nil {
		tx.Rollback()
		return err
	}
	fmt.Println(res.RowsAffected())
		
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
	return nil
}