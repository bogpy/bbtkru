package repository

import (
	"fmt"
	"log"
	"strings"

	"github.com/bogpy/bbtkru/internal/models"
	"github.com/jmoiron/sqlx"
)

type ApplicantRepository struct {
	DB *sqlx.DB
}

func NewApplicantRepository(db *sqlx.DB) *ApplicantRepository {
	return &ApplicantRepository{DB: db}
}

func (r ApplicantRepository) BulkInsert(applicants []*models.Applicant) error {
	query := `INSERT INTO applicant
		(name, dateOfBirth, education, university, graduated, specialty, level, experience, workHistory)
		VALUES (:name, :dateOfBirth, :education, :university, :graduated, :specialty, :level, :experience, :workHistory)`
	return NamedExecWrapper(r.DB, query, applicants)
}

func (r ApplicantRepository) GetLanguagesIds(languages []models.Language) ([]int64, error) {
	query := `SELECT l.id FROM language l
			  WHERE l.name IN (?)`

	language_names := make([]string, len(languages))
	for i, lang := range languages {
		language_names[i] = lang.Name
	}
	query, args, err := sqlx.In(query, language_names)
	if err != nil {
		return nil, err
	}
	var languages_ids []int64
	query = r.DB.Rebind(query)
	err = r.DB.Select(&languages_ids, query, args...)
	if err != nil {
		return nil, err
	}

	return languages_ids, nil
}

func (r ApplicantRepository) GetLanguages(id int64) ([]models.Language, error) {
	query := `SELECT l.id, l.name
	 		  FROM language l
			  JOIN applicant_language al ON l.id = al.language_id
			  WHERE al.applicant_id = ?
			  `
	var languages []models.Language
	err := r.DB.Select(&languages, query, id)
	if err != nil {
		return nil, err
	}
	return languages, err
}

func (r ApplicantRepository) GetTechnologiesIds(technologies []models.Technology) ([]int64, error) {
	query := `SELECT t.id FROM technology t
			  WHERE t.name IN (?)`

	technology_names := make([]string, len(technologies))
	for i, tech := range technologies {
		technology_names[i] = tech.Name
	}
	query, args, err := sqlx.In(query, technology_names)
	if err != nil {
		return nil, err
	}
	var technology_ids []int64
	query = r.DB.Rebind(query)
	err = r.DB.Select(&technology_ids, query, args...)
	if err != nil {
		return nil, err
	}

	return technology_ids, nil
}

func (r ApplicantRepository) GetTechnologies(id int64) ([]models.Technology, error) {
	query := `SELECT t.id, t.name
	 		  FROM technology t
			  JOIN applicant_technology at ON t.id = at.technology_id
			  WHERE at.applicant_id = ?
			  `
	var technologies []models.Technology
	err := r.DB.Select(&technologies, query, id)
	if err != nil {
		return nil, err
	}

	return technologies, nil
}

func (r ApplicantRepository) GetApplicants(request models.RequestForApplicant) ([]models.Applicant, error) {
	var queryBuilder strings.Builder
	queryBuilder.WriteString("SELECT * FROM applicant a WHERE 1=1")
	var args []any

	if request.Experience != nil {
		queryBuilder.WriteString(" AND experience >= ?")
		args = append(args, *request.Experience)
	}

	if request.Level != nil {
		queryBuilder.WriteString(" AND level = ?")
		args = append(args, *request.Level)
	}

	if request.Graduated != nil {
		queryBuilder.WriteString(" AND graduated = ?")
		args = append(args, *request.Graduated)
	}

	if request.Education_type != nil {
		queryBuilder.WriteString(" AND education = ?")
		args = append(args, *request.Education_type)
	}

	if request.Specialty != nil {
		queryBuilder.WriteString(" AND specialty = ?")
		args = append(args, *request.Specialty)
	}

	if len(request.LanguagesRequired.Items) > 0 {
		queryBuilder.WriteString(
			` AND EXISTS (
				SELECT 1 FROM applicant_language al
				WHERE al.applicant_id = a.id AND al.language_id IN (?)
				GROUP BY al.applicant_id
				HAVING COUNT(DISTINCT al.language_id) = ?
			)`,
		)
		languages_ids, err := r.GetLanguagesIds(request.LanguagesRequired.Items)
		if err != nil {
			return nil, err
		}
		if len(languages_ids) != len(request.LanguagesRequired.Items) {
			return nil, fmt.Errorf(
				"Non existing languages in request: %v\n",
				request.LanguagesRequired)
		}
		args = append(
			args,
			languages_ids,
			len(languages_ids),
		)
	}

	if len(request.TechnologiesRequired.Items) > 0 {
		queryBuilder.WriteString(
			` AND EXISTS (
				SELECT 1 FROM applicant_technology at
				WHERE at.applicant_id = a.id AND at.technology_id IN (?)
				GROUP BY at.applicant_id
				HAVING COUNT(DISTINCT at.technology_id) = ?
			)`,
		)
		technologies_ids, err := r.GetTechnologiesIds(request.TechnologiesRequired.Items)
		if err != nil {
			return nil, err
		}
		if len(technologies_ids) != len(request.TechnologiesRequired.Items) {
			return nil, fmt.Errorf(
				"Non existing technologies in request: %v\n",
				request.TechnologiesRequired)
		}
		args = append(
			args,
			technologies_ids,
			len(technologies_ids),
		)
	}

	query := queryBuilder.String()
	query, args, err := sqlx.In(query, args...)
	if err != nil {
		log.Printf(`Query expansion failure: %v
			Query: %v
			Args: %v
		`, err, query, args)
		return nil, err
	}
	query = r.DB.Rebind(query)
	var applicants []models.Applicant
	err = r.DB.Select(&applicants, query, args...)
	if err != nil {
		log.Printf("Select failure: %v\nQuery: %v\n", err, query)
		return nil, err
	}

	for i, applicant := range applicants {
		var err error
		applicants[i].Languages, err = r.GetLanguages(applicant.ID)
		if err != nil {
			log.Printf("Error %v no gotten lang", err)
			return nil, err
		}
		applicants[i].Technologies, err = r.GetTechnologies(applicant.ID)
		if err != nil {
			return nil, err
		}
	}
	// add ids retrieval for LanguagesOptional and TechnologiesOptional

	for i, applicant := range applicants {
		applicants[i].Score = applicant.CalcScore(request)
	}
	return applicants, err
}

type ApplicantLanguage struct {
	ApplicantID int64 `db:"applicant_id"`
	LanguageID  int64 `db:"language_id"`
}

type ApplicantTechnology struct {
	ApplicantID  int64 `db:"applicant_id"`
	TechnologyID int64 `db:"technology_id"`
}

func (r ApplicantRepository) InsertJunction(applicants []*models.Applicant, language_ids map[string]int64, technology_ids map[string]int64) error {
	query := `INSERT INTO applicant_language
				(applicant_id, language_id)
				VALUES (:applicant_id,  :language_id)
			`
	var args1 []ApplicantLanguage
	for _, applicant := range applicants {
		for _, language := range applicant.GetLanguages() {
			languageID, ok := language_ids[language.Name]
			if !ok {
				return fmt.Errorf("id not found for language %v", language.Name)
			}
			args1 = append(args1, ApplicantLanguage{applicant.ID, languageID})
		}
	}
	tx := r.DB.MustBegin()
	_, err := tx.NamedExec(query, args1)
	if err != nil {
		tx.Rollback()
		return err
	}
	query = `INSERT INTO applicant_technology
				(applicant_id, technology_id)
				VALUES (:applicant_id, :technology_id)
				`
	var args2 []ApplicantTechnology
	for _, applicant := range applicants {
		for _, technology := range applicant.GetTechnologies() {
			technologyID, ok := technology_ids[technology.Name]
			if !ok {
				return fmt.Errorf("id not found for technology %v", technology.Name)
			}
			args2 = append(args2, ApplicantTechnology{applicant.ID, technologyID})
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

func (r ApplicantRepository) GetApplicantByID(id int64) (*models.Applicant, error) {
	var applicant models.Applicant
	var err error
	err = r.DB.Get(
		&applicant,
		"SELECT * FROM applicant WHERE (id) = (?)",
		id,
	)
	if err != nil {
		return nil, err
	}
	applicant.Languages, err = r.GetLanguages(applicant.ID)
	if err != nil {
		return nil, err
	}
	applicant.Technologies, err = r.GetTechnologies(applicant.ID)
	if err != nil {
		return nil, err
	}
	return &applicant, nil
}

func (r ApplicantRepository) InsertApplicant(a *models.Applicant) error {
	query := `INSERT INTO applicant
		(name, dateOfBirth, education, university, graduated, specialty, level, experience, workHistory)
		VALUES (:name, :dateOfBirth, :education, :university, :graduated, :specialty, :level, :experience, :workHistory)`
	res, err := r.DB.NamedExec(query, a)
	if err != nil {
		return err
	}
	id, err := res.LastInsertId()
	if err != nil {
		return fmt.Errorf("addApplicant: %v", err)
	}
	a.ID = id
	return nil
}

func (r ApplicantRepository) DeleteApplicant(id int64) error {
	result, err := r.DB.Exec("DELETE FROM applicant WHERE id = ?", id)
	if err != nil {
		return err
	}
	count, err := result.RowsAffected()
	if err != nil {
		return err
	}
	if count == 0 {
		return fmt.Errorf("Not found applicant with id: %v", id)
	}

	return nil
}
