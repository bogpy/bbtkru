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
	ID                int64 `db:"DB"`
	Title             string `db:"Title"`
	Description       string `db:"Description"`
	CompanyID         int64 `db:"CompanyID"`
	CompanyName       string `db:"CompanyName"`
	Experience        int `db:"Experience"`
	Salary            int `db:"Salary"`
	Hours             int `db:"Hours"`
	Employment        EmploymentType `db:"Employment"`
	Location          LocationType `db:"Location"`
	LanguagesRequired []Language
	LanguagesOptional []Language
	Score             int
}

func (x *Vacancy) set_ID(id int64) {
	x.ID =  id
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
	var vacancies []Vacancy
	err := db.Select(&vacancies, query, args...)
	if err != nil {
		return nil, err
	}

	for _, vacancy := range vacancies {
		err := vacancy.GetLanguages(db)
		if err != nil {
			return nil, err
		}
		err := vacancy.GetTechnologies(db)
		if err != nil {
			return nil, err
		}
	}

	return vacancies, nil
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
