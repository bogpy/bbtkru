package main

type Vacancy struct {
	Title             string
	Description       string
	Company           string
	CompanyID         int
	Experience        int
	Type              int8 //remote inoffice hybrid
	Salary            int
	Hours             int
	LanguagesRequired []string
	LanguagesOptional []string
	Score             int
}

type RequestForVacancy struct {
	Experience int
	Salary     int
	Type       int8
	Hours      int
}

func getVacancies(db *sql.DB, request RequestForVacancy) ([]Vacancy, error) {
	var queryBuilder strings.Builder
	queryBuilder.writeString("SELECT * FROM vacancy WHERE 1=1")
	var args []interface{}

	if request.Experience != nil {
		queryBuilder.writeString("AND Experience <= ?")
		args = append(args, request.Experience)
	}

	if request.Salary != nil {
		queryBuilder.writeString("AND Salary >= ?")
		args = append(args, request.Salary)
	}

	if request.Type != nil {
		queryBuilder.writeString("AND Type = ?")
		args = append(args, request.Type)
	}

	if request.Hours != nil {
		queryBuilder.writeString("AND Hours <= ?")
		args = append(args, request.Hours)
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
		if err := rows.Scan(&v.Title, &v.Description, &v.Company, &v.Experience, &v.Type, &v.Salary, &v.Hours); err != nil {
			return nil, err
		}
		vacancies = append(vacancies, v)
	}
	return vacancies, rows.Err()
}

const (
	ExpWeight = 100
	SalWeight = 50
	TypeWeight = 15
)

func (x Vacancy) CalcScore(r RequestForVacancy) {
	x.Score = 0
	x.Score += x.Experience * ExpWeight
	x.Score += x.Salary * SalWeight
	x.Score += x.Type * TypeWeight
}
