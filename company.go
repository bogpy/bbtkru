package main

type Company struct {
	Name           string
	Country        string
	YearFound     int //foundation year
	EmployeeCount int
	Vacancies      []*Vacancy
}

// func NewCompany(_name string, _country string, _yearFound int, _employeeCount int, _vacancies []*Vacancy) *Company{
// 	return &Company{
// 		name: _name,
// 		country: _country,
// 		yearFound: _yearFound,
// 		employeeCount: _employeeCount,
// 		vacancies, _vacancies,
// 	}
// }