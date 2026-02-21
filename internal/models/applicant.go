package models

import (
	"sort"
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
	ID           int64         `db:"id" json:"id"`
	Name         string        `db:"name" json:"name"`
	DateOfBirth  time.Time     `db:"dateOfBirth" json:"dateOfBirth"`
	Education    EducationType `db:"education" json:"education"`
	University   string        `db:"university" json:"university"`
	Graduated    bool          `db:"graduated" json:"graduated"`
	Specialty    SpecialtyType `db:"specialty" json:"specialty"`
	Level        LevelType     `db:"level" json:"level"`
	Experience   int           `db:"experience" json:"experience"`
	WorkHistory  string        `db:"workHistory" json:"workHistory"`
	Languages    []Language
	Technologies []Technology
	Score        int
}

func (x *Applicant) SetID(id int64) {
	x.ID = id
}

func (x *Applicant) GetID() int64 {
	return x.ID
}

func (x *Applicant) GetLanguages() []Language{
	return x.Languages
}

func (x *Applicant) GetTechnologies() []Technology {
	return x.Technologies
}

type RequestForApplicant struct {
	Experience           *int
	Level                *LevelType
	Graduated            *bool
	Education_type       *EducationType
	Specialty            *SpecialtyType
	LanguagesRequired    []Language
	LanguagesOptional    []Language
	TechnologiesRequired []Technology
	TechnologiesOptional []Technology
}

const (
	AppExpWeight = 100
	LangWeight   = 52
	TechWeight   = 10
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
