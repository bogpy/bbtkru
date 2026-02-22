package models

import (
	"encoding/json"
	"fmt"
)

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
