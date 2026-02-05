package main

import (
	"database/sql"
	"strings"
)

type EmploymentType string

const (
	Internship EmploymentType = "Internship"
	FullTime   EmploymentType = "Full-time"
	PartTime   EmploymentType = "Part-time"
)

type LocationType string

const (
	Remote   LocationType = "Remote"
	Hybrid   LocationType = "Hybrid"
	InOffice LocationType = "In-office"
)

type Vacancy struct {
	ID                int `db:"DB"`
	Title             string `db:"Title"`
	Description       string `db:"Description"`
	CompanyID         int `db:"CompanyID"`
	CompanyName       string `db:"CompanyName"`
	Experience        int `db:"Experience"`
	Salary            int `db:"Salary"`
	Hours             int `db:"Hours"`
	Employment        EmploymentType `db:"Employment"`
	Location          LocationType `db:"Location"`
	LanguagesRequired []string
	LanguagesOptional []string
	Score             int
}

type RequestForVacancy struct {
	Experience *int
	Salary     *int
	Type       *int8
	Hours      *int
}

func getVacancies(db *sql.DB, request RequestForVacancy) ([]Vacancy, error) {
	var queryBuilder strings.Builder
	queryBuilder.WriteString("SELECT * FROM vacancy WHERE 1=1")
	var args []interface{}

	if request.Experience != nil {
		queryBuilder.WriteString("AND Experience <= ?")
		args = append(args, *request.Experience)
	}

	if request.Salary != nil {
		queryBuilder.WriteString("AND Salary >= ?")
		args = append(args, *request.Salary)
	}

	if request.Type != nil {
		queryBuilder.WriteString("AND Type = ?")
		args = append(args, *request.Type)
	}

	if request.Hours != nil {
		queryBuilder.WriteString("AND Hours <= ?")
		args = append(args, *request.Hours)
	}

	query := queryBuilder.String()
	rows, err := db.Query(query, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var vacancies []Vacancy
	for rows.Next() {
		var v Vacancy
		if err := rows.Scan(&v.Title, &v.Description, &v.CompanyID, &v.Experience, &v.Employment, &v.Location, &v.Salary, &v.Hours); err != nil {
			return nil, err
		}
		vacancies = append(vacancies, v)
	}
	return vacancies, rows.Err()
}

const (
	ExpWeight   = 100
	SalWeight   = 50
	EmploymentWeight  = 15
	HoursWeight = 10
)

func (x Vacancy) CalcScore(r RequestForVacancy) {
	x.Score = 0
	x.Score += x.Experience * ExpWeight
	x.Score += x.Salary * SalWeight
	// x.Score += x.Employment * EmploymentWeight
	x.Score += x.Hours * HoursWeight
}
