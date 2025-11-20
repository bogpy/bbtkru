package main

type Vacancy struct {
	Title                    string
	Description              string
	Company                  *Company
	Necessary_experience     int
	Work_type                int8 //remote inoffice outoffice
	Salary_start, salary_end int
	Work_hours               int
}

// func NewVacancy(_company *Company, _title string) *Vacancy{
// 	return &Company{
// 		company: _company,
// 		title: _title,
// 	}
// }
