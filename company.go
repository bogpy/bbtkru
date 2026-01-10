package main

type Company struct {
	Name          string
	Country       string
	YearFound     int //foundation year
	EmployeeCount int
	Vacancies     []*Vacancy
}

func delete