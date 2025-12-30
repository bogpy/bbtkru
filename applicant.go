package main

import (
	"sort"
)

type Applicant struct {
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
