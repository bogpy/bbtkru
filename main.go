package main

import (
	"errors"
	"encoding/json"
	"fmt"
	"github.com/jmoiron/sqlx"
)

var ErrNotSupported = errors.New("Operation not supported")

type ID_setter interface {
	set_ID(int64)
}

type Language struct {
	ID   int64  `db:"ID"`
	Name string `db:"Name"`
}

func (x *Language) set_ID(id int64) {
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
	ID   int64  `db:"ID"`
	Name string `db:"Name"`
}

func (x *Technology) set_ID(id int64) {
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

func main() {
	var db *sqlx.DB
	db = connectDB()
	defer db.Close()
	initDB(db)
	populateDB(db)
}
