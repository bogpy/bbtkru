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
	Languages    []Language
	Technologies []Technology
	Score        int
}

func (x *Applicant) set_ID(id int64) {
	x.ID = id
}

type RequestForApplicant struct {
	Experience        *int
	Level             *LevelType
	Graduated         *bool
	Education_type    *Education_type
	Specialty         *SpecialtyType
	LanguagesRequired []Language
	LanguagesOptional []Language
	TechnologiesRequired []Technology
	TechnologiesOptional []Technology
}

func getApplicants(db *sqlx.DB, request RequestForApplicant) ([]Applicant, error) {
	var queryBuilder strings.Builder
	queryBuilder.WriteString("SELECT * FROM applicant a WHERE 1=1")
	var args []interface{}

	if request.Experience != nil {
		queryBuilder.WriteString("AND Experience >= ?")
		args = append(args, *request.Experience)
	}

	if request.Level != nil {
		queryBuilder.WriteString("AND Level = ?")
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

	if request.Specialty != nil {
		queryBuilder.WriteString("AND Specialty = ?")
		args = append(args, *request.Specialty)
	}

	if len(request.LanguagesRequired) > 0 {
		queryBuilder.WriteString(
			"AND EXISTS (
				SELECT 1 FROM applicant_language al
				WHERE al.applicant_id = a.ID AND al.language_id IN (?)
				GROUP BY al.applicant_id
				HAVING COUNT(DISTINCT al.applicant_id) = ?
			)"
		)
		languages_ids = make([]int64, len(request.LanguagesRequired))
		for i, language := range request.LanguagesRequired {
			languages_ids[i] = language.ID
		}
		args = append(
			args,
			languages_ids,
			len(languages_ids)
		)
	}
	
	if len(request.TechnologiesRequired) > 0 {
		queryBuilder.WriteString(
			"AND EXISTS (
				SELECT 1 FROM applicant_technology at
				WHERE at.applicant_id = a.ID AND at.technology_id IN (?)
				GROUP BY at.applicant_id
				HAVING COUNT(DISTINCT at.applicant_id) = ?
			)"
		)
		technologies_ids = make([]int64, len(request.TechnologiesRequired))
		for i, technology := range request.TechnolgiesRequired {
			technologies_ids[i] = technology.ID
		}
		args = append(
			args,
			technologies_ids,
			len(technologies_ids)
		)
	}

	query := queryBuilder.String()
	var applicants []Applicant
	err := db.Select(&applicants, query, args...)
	if err != nil {
		return nil, err
	}

	for _, applicant := range applicants {
		err : = applicant.GetLanguages(db)
		if err != nil {
			return nil, err
		}
		err : = applicant.GetTechnologies(db)
		if err != nil {
			return nil, err
		}
	}

	for _, applicant := range applicants {
		applicant.CalcScore(request)
	}

	return applicants, nil
}

func (applicant *Applicant) GetLanguages(db *sqlx.DB) (error){
	query := `SELECT l.ID, l.Name
	 		  FROM language l
			  JOIN applicant_language al ON l.ID = al.language_id
			  WHERE al.applicant_id = ?
			  `
	var languages []Language
	err := db.Select(&languages, query, applicant.ID)
	if err != nil{
		return err
	}

	applicant.Languages = languages
}

func (applicant *Applicant) GetTechnologies(db *sqlx.DB) (error){
	query := `SELECT t.ID, t.Name
	 		  FROM technology t
			  JOIN applicant_technology at ON t.Id = at.technology_id
			  WHERE at.applicant_id = ?
			  `
	var technologies []Technology
	err := db.Select(&technologies, query, applicantId)
	if err != nil{
		return err
	}
	
	applicant.Technologies = technologies
}

const (
	AppExpWeight  = 100
	LangWeight = 52
	TechWeight = 10
)

func (x *Applicant) CalcScore(r RequestForApplicant) {
	x.Score = 0
	x.Score += x.Experience * ExpWeight

	if r.LanguagesOptional != nil {
		var cnt = 0
		mp := make(map[int64]bool)
		for _, lang := range r.LanguagesOptional {
			mp[lang.ID] = true
		}
		for _, lang := range x.Languages {
			if mp[lang.ID] {
				cnt++
			}
		}
		x.Score += cnt * LangWeight
	}
	if r.TechnologiesOptional != nil {
		var cnt = 0
		mp := make(map[int64]bool)
		for _, tech := range r.TechnologiesOptional {
			mp[tech.ID] = true
		}
		for _, tech := range x.Technologies {
			if mp[tech.ID] {
				cnt++
			}
		}
		x.Score += cnt * TechWeight
	}
}

func SortIntern(s []Applicant, r RequestForApplicant) {
	for _, x := range s {
		x.CalcScore(r)
	}
	sort.Slice(s, func(i, j int) bool {
		return s[i].Score > s[j].Score
	})
}
