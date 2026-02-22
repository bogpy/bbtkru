package repository

import (
	"fmt"
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

func (r ApplicantRepository) GetLanguages(id int64) ([]models.Language, error) {
	query := `SELECT l.ID, l.Name
	 		  FROM language l
			  JOIN applicant_language al ON l.ID = al.language_id
			  WHERE al.applicant_id = ?
			  `
	var languages []models.Language
	err := r.DB.Select(&languages, query, id)
	if err != nil {
		return nil, err
	}
	return languages, err
}

func (r ApplicantRepository) GetTechnologies(id int64) ([]models.Technology, error) {
	query := `SELECT t.ID, t.Name
	 		  FROM technology t
			  JOIN applicant_technology at ON t.Id = at.technology_id
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
	var args []interface{}

	if request.Experience != nil {
		queryBuilder.WriteString("AND experience >= ?")
		args = append(args, *request.Experience)
	}

	if request.Level != nil {
		queryBuilder.WriteString("AND level = ?")
		args = append(args, *request.Level)
	}

	if request.Graduated != nil {
		queryBuilder.WriteString("AND graduted = ?")
		args = append(args, *request.Graduated)
	}

	if request.Education_type != nil {
		queryBuilder.WriteString("AND education = ?")
		args = append(args, *request.Education_type)
	}

	if request.Specialty != nil {
		queryBuilder.WriteString("AND specialty = ?")
		args = append(args, *request.Specialty)
	}

	if len(request.LanguagesRequired) > 0 {
		queryBuilder.WriteString(
			`AND EXISTS (
				SELECT 1 FROM applicant_language al
				WHERE al.applicant_id = a.id AND al.language_id IN (?)
				GROUP BY al.applicant_id
				HAVING COUNT(DISTINCT al.applicant_id) = ?
			)`,
		)
		languages_ids := make([]int64, len(request.LanguagesRequired))
		for i, language := range request.LanguagesRequired {
			languages_ids[i] = language.ID
		}
		args = append(
			args,
			languages_ids,
			len(languages_ids),
		)
	}

	if len(request.TechnologiesRequired) > 0 {
		queryBuilder.WriteString(
			`AND EXISTS (
				SELECT 1 FROM applicant_technology at
				WHERE at.applicant_id = a.id AND at.technology_id IN (?)
				GROUP BY at.applicant_id
				HAVING COUNT(DISTINCT at.applicant_id) = ?
			)`,
		)
		technologies_ids := make([]int64, len(request.TechnologiesRequired))
		for i, technology := range request.TechnologiesRequired {
			technologies_ids[i] = technology.ID
		}
		args = append(
			args,
			technologies_ids,
			len(technologies_ids),
		)
	}

	query := queryBuilder.String()
	var applicants []models.Applicant
	err := r.DB.Select(&applicants, query, args...)
	if err != nil {
		return nil, err
	}

	for i, applicant := range applicants {
		var err error
		applicants[i].Languages, err = r.GetLanguages(applicant.ID)
		if err != nil {
			return nil, err
		}
		applicants[i].Technologies, err = r.GetTechnologies(applicant.ID)
		if err != nil {
			return nil, err
		}
	}

	for i, applicant := range applicants {
		applicants[i].Score = applicant.CalcScore(request)
	}

	return applicants, err
}

type ApplicantLanguage struct {
	ApplicantID int64 `db:"applicant_id"`
	LanguageID int64 `db:"language_id"`
}

type ApplicantTechnology struct {
	ApplicantID int64 `db:"applicant_id"`
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
	return nil
}