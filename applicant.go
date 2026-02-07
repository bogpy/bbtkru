package main

import (
	"database/sql"
	"sort"
	"strings"
	"time"
)

type EducationType string

const (
	HighSchool EducationType = "High School"
	Bachelor   EducationType = "Bachelor"
	Master     EducationType = "Master"
	PhD        EducationType = "PhD"
)

type SpecialtyType string

const (
	Frontend     SpecialtyType = "Frontend"
	Backend      SpecialtyType = "Backend"
	Fullstack    SpecialtyType = "Fullstack"
	DataEngineer SpecialtyType = "DataEngineer"
	DevOps       SpecialtyType = "DevOps"
)

type LevelType string

const (
	Intern LevelType = "Intern"
	Junior LevelType = "Junior"
	Middle LevelType = "Middle"
	Senior LevelType = "Senior"
	Lead   LevelType = "Lead"
)

type Applicant struct {
	ID           int64 `db:"ID"`
	Name         string `db:"Name"`
	DateOfBirth  time.Time `db:"DateOfBirth"`
	Education    EducationType `db:"Education"`
	University   string `db:"University"`
	Graduated    bool `db:"Graduated"`
	Specialty    SpecialtyType `db:"Specialty"`// backend frontend fullstack
	Level        LevelType `db:"Level"`
	Experience   int `db:"Experience"`
	WorkHistory  string `db:"WorkHistory"`
	Languages    []string
	Technologies []string
	Score        int
}

func (x *Applicant) set_ID(id int64) {
	x.ID = id
}

type RequestForApplicant struct {
	Experience        *int
	Level             *int8
	Graduated         *bool
	Education_type    *int
	Specialty         string
	LanguagesRequired []string
	LanguagesOptional []string
}

func getApplicants(db *sql.DB, request RequestForApplicant) ([]Applicant, error) {
	var queryBuilder strings.Builder
	queryBuilder.WriteString("SELECT * FROM applicant WHERE 1=1")
	var args []interface{}

	if request.Experience != nil {
		queryBuilder.WriteString("AND Experience >= ?")
		args = append(args, *request.Experience)
	}
	//add other requests
	/*if request.LanguagesRequired != nil {
		mp := make(map[string]bool)
		for _, lang := request.LanguagesRequired {
			mp[lang] = 1
		}
		//args = append(args, request.experience).........
	}*/

	if request.Level != nil {
		queryBuilder.WriteString("AND Level >= ?")
		args = append(args, *request.Level)
	}

	if request.Graduated != nil {
		queryBuilder.WriteString("AND Graduted = ?")
		args = append(args, *request.Graduated)
	}

	if request.Education_type != nil {
		queryBuilder.WriteString("AND Education = ?")
		args = append(args, *request.Education_type)
	}

	query := queryBuilder.String()
	rows, err := db.Query(query, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var applicants []Applicant
	for rows.Next() {
		var a Applicant
		if err := rows.Scan(&a.ID, &a.Name, &a.Experience, &a.University, &a.Level, &a.Graduated, &a.WorkHistory, &a.Education, &a.Specialty, &a.Languages, &a.Technologies); err != nil {
			return nil, err
		}
		applicants = append(applicants, a)
	}
	return applicants, rows.Err()
}

const (
	AppExpWeight  = 100
	LangWeight = 52
)

func (x Applicant) CalcScore(r RequestForApplicant) {
	x.Score = 0
	x.Score += x.Experience * ExpWeight

	cnt := 0
	if r.LanguagesOptional != nil {
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
