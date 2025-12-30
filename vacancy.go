package main

type Vacancy struct {
	Title                    string
	Description              string
	Company                  string
	// CompanyID                int
	Experience     int
	Type                int8 //remote inoffice outoffice
	Salary int
	Hours               int
}

// func NewVacancy(_company *Company, _title string) *Vacancy{
// 	return &Company{
// 		company: _company,
// 		title: _title,
// 	}
// }
