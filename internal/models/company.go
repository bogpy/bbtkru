package models

type Company struct {
	ID            int64  `db:"id" json:"id"`
	Name          string `db:"name" json:"name"`
	Country       string `db:"country" json:"country"`
	YearFound     int    `db:"yearFound" json:"yearFound"`
	EmployeeCount int    `db:"employeeCount" json:"employeeCount"`
	Score         int
}

func (x *Company) SetID(id int64) {
	x.ID = id
}

type RequestForCompany struct {
	Country       *string
	EmployeeCount *int
}

const (
	RevWeight      = 50
	EmployeeWeight = 25
)

func (x Company) CalcScore(r RequestForCompany) {
	x.Score = 0
	// x.Score += x.RevenuePerYear * RevWeight
	x.Score += x.EmployeeCount * EmployeeWeight
}
