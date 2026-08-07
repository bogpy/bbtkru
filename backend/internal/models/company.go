package models

type Company struct {
	ID            int64     `db:"id" json:"id"`
	Name          string    `db:"name" json:"name" binding:"required,max=100"`
	Country       string    `db:"country" json:"country" binding:"required,max=50"`
	YearFound     int       `db:"yearFound" json:"yearFound" binding:"required,gte=1"`
	EmployeeCount int       `db:"employeeCount" json:"employeeCount" binding:"gte=0"`
	OwnerUserID   *int64    `db:"ownerUserID" json:"-"`
	Vacancies     []Vacancy `json:"vacancies"`
	Score         int       `json:"score"`
}

func (x *Company) SetID(id int64) {
	x.ID = id
}

type RequestForCompany struct {
	Name          *string `form:"name"`
	Country       *string `form:"country"`
	EmployeeCount *int    `form:"employeeCount"`
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
