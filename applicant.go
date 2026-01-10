package main

import (
	"sort"
)

type Applicant struct {
	ID 			 int
	Name         string
	Age          int
	Experience   int
	University   string
	Level        int8
	Graduated    bool
	Companies    []string
	Education    int
	Specialty    int // backend frontend fullstack
	Languages    []string
	Technologies []string
	Score        int
}

type RequestForApplicant struct {
	Experience        int
	Level             int8
	Graduated         bool
	Education_type    string
	Specialty         string
	LanguagesRequired []string
	LanguagesOptional []string
} 

func getApplicants(db *sql.DB, request RequestForApplicant) ([]Applicant, error) {
	var queryBuilder strings.Builder
	queryBuilder.writeString("SELECT ID, Name, Age, Experience, University, Level, Graduated, Companies, Education, Specialty, Languages, Technologies FROM applicant WHERE 1=1")
	var args []interface{}

	if request.experience != nil {
		queryBuilder.writeString("AND Experience >= ?")
		args = append(args, request.experience)
	}
	//add other requests
	query := queryBuilder.String()
	rows, err := db.Query(query, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var applicants []Applicant
	for rows.Next() {
		var a Applicant
		if err := rows.Scan(a.ID, a.Name, a.Age, a.Experience, a.University, a.Level, a.Graduated, a.Companies, a.Education, a.Specialty, a.Languages, a.Technologies) {
			return nil, err
		}
		applicants = append(applicants, a)
	}
	return applicants, rows.Err()
}

const (
	ExpWeight  = 100
	LangWeight = 52
)

func (x Applicant) CalcScore(r RequestForApplicant) {
	x.Score = 0
	x.Score += x.Experience * ExpWeight

	var cnt = 0
	mp := make(map[string]bool)
	for _, lang := range r.LanguagesOptional {
		mp[lang] = true
	}
	for _, lang := range x.Languages {
		if mp[lang] {
			cnt++
		}
	}

	x.Score += cnt * LangWeight
}

func SortIntern(s []Applicant, r RequestForApplicant) {
	for _, x := range s {
		x.CalcScore(r)
	}
	sort.Slice(s, func(i, j int) bool {
		return s[i].Score > s[j].Score
	})
}
