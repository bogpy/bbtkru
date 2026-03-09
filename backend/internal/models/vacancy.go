package models

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
	ID                int64          `db:"id" json:"id"`
	Title             string         `db:"title" json:"title"`
	Description       string         `db:"description" json:"description"`
	CompanyID         int64          `db:"companyID" json:"-"`
	CompanyName       string         `db:"-" json:"companyName"`
	Experience        int            `db:"experience" json:"experience"`
	Salary            int            `db:"salary" json:"salary"`
	Hours             int            `db:"hours" json:"hours"`
	Employment        EmploymentType `db:"employment" json:"employment"`
	Location          LocationType   `db:"location" json:"location"`
	Languages []Language
	Technologies []Technology
	Score             int
}

func (x *Vacancy) SetID(id int64) {
	x.ID = id
}

func (x *Vacancy) GetID() int64 {
	return x.ID
}

func (x *Vacancy) GetLanguages() []Language {
	return x.Languages
}

func (x *Vacancy) GetTechnologies() []Technology {
	return x.Technologies
}

type RequestForVacancy struct {
	Experience *int
	Salary     *int
	Type       *int8
	Hours      *int
}

const (
	ExpWeight        = 100
	SalWeight        = 50
	EmploymentWeight = 15
	HoursWeight      = 10
)

func (x Vacancy) CalcScore(r RequestForVacancy) {
	x.Score = 0
	x.Score += x.Experience * ExpWeight
	x.Score += x.Salary * SalWeight
	// x.Score += x.Employment * EmploymentWeight
	x.Score += x.Hours * HoursWeight
}
