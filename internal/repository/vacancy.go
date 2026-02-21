package repository

import (
	// "database/sql"
	"strings"

	"github.com/bogpy/bbtkru/internal/models"
	"github.com/jmoiron/sqlx"
)

func getVacancies(db *sqlx.DB, request models.RequestForVacancy) ([]models.Vacancy, error) {
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
	err := db.Select(&vacancies, query, args...)
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
