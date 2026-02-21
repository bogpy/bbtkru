package repository

import (
	"strings"

	"github.com/bogpy/bbtkru/internal/models"
	"github.com/jmoiron/sqlx"
)

func getApplicants(db *sqlx.DB, request models.RequestForApplicant) ([]models.Applicant, error) {
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
	err := db.Select(&applicants, query, args...)
	if err != nil {
		return nil, err
	}

	for _, applicant := range applicants {
		err := GetLanguages(&applicant, db)
		if err != nil {
			return nil, err
		}
		err = GetTechnologies(&applicant, db)
		if err != nil {
			return nil, err
		}
	}

	for _, applicant := range applicants {
		applicant.CalcScore(request)
	}

	return applicants, err
}

func GetLanguages(applicant *models.Applicant, db *sqlx.DB) error {
	query := `SELECT l.ID, l.Name
	 		  FROM language l
			  JOIN applicant_language al ON l.ID = al.language_id
			  WHERE al.applicant_id = ?
			  `
	var languages []models.Language
	err := db.Select(&languages, query, applicant.ID)
	if err != nil {
		return err
	}

	applicant.Languages = languages
	return err
}

func GetTechnologies(applicant *models.Applicant, db *sqlx.DB) error {
	query := `SELECT t.ID, t.Name
	 		  FROM technology t
			  JOIN applicant_technology at ON t.Id = at.technology_id
			  WHERE at.applicant_id = ?
			  `
	var technologies []models.Technology
	err := db.Select(&technologies, query, applicant.ID)
	if err != nil {
		return err
	}

	applicant.Technologies = technologies
	return err
}
