package models

import (
	"encoding/json"
	"errors"
	"fmt"
)

var ErrNotSupported = errors.New("Operation not supported")

type Language struct {
	ID   int64  `db:"id" json:"id"`
	Name string `db:"name" json:"name"`
}

func (x *Language) SetID(id int64) {
	x.ID = id
}

func (x *Language) UnmarshalJSON(data []byte) error {
	var name string
	if err := json.Unmarshal(data, &name); err != nil {
		return fmt.Errorf("Invalid language name %v: %w", data, err)
	}
	x.Name = name
	return nil
}

type Technology struct {
	ID   int64  `db:"id" json:"id"`
	Name string `db:"name" json:"name"`
}

func (x *Technology) SetID(id int64) {
	x.ID = id
}

func (x *Technology) UnmarshalJSON(data []byte) error {
	var name string
	if err := json.Unmarshal(data, &name); err != nil {
		return fmt.Errorf("Invalid technology name %v: %w", data, err)
	}
	x.Name = name
	return nil
}

type ApplicantLanguage struct {
	ApplicantID int64 `db:"applicant_id"`
	LanguageID int64 `db:"language_id"`
}

type ApplicantTechnology struct {
	ApplicantID int64 `db:"applicant_id"`
	TechnologyID int64 `db:"techonology_id"`
}

type VacancyLanguage struct {
	VacancyID int64 `db:"vacancy_id"`
	LanguageID int64 `db:"language_id"`
}

type VacancyTechnology struct {
	VacancyID int64 `db:"vacancy_id"`
	TechnologyID int64 `db:"techonology_id"`
}