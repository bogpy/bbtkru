package main

import (
	"database/sql"
	"fmt"
	"github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"log"
	"os"
)

func bulkInsertSql[T any](db *sqlx.DB, arr []T) {
	var query string
	var el T
	switch any(el).(type) {
	default:
		log.Fatal("Not supported")
	case Company:
		query = `INSERT INTO company
			(Name, Country, YearFound, EmployeeCount)
			VALUES (:Name, :Country, :Year, :EmployeeCount)`
	case Applicant:
		query = `INSERT INTO applicant
			(Name, Age, Education, University, Graduated, Specialty, Level, Experience, WorkHistory)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`
	case Vacancy:
		query = `INSERT INTO vacancy
			(Title, Description, CompanyID, Experience, Salary,
			Hours, Employment, Location) 
			VALUES (?, ?, ?, ?, ?, ?, ?, ?)`
	case Language:
		query = `INSERT INTO language (Name) VALUES (:Name)`
	case Technology:
		query = `INSERT INTO technology (Name) VALUES (:Name)`
	}
	query, args, err := sqlx.In(query, arr)
	if err != nil {
		fmt.Errorf("insertSql: %v", err)
	}
	query = sqlx.Rebind(sqlx.QUESTION, query)
	_, err = db.Exec(query, args...)
	if err != nil {
		fmt.Errorf("insertSql: %v", err)
	}
}

func insertSql[T any](db *sqlx.DB, ent *T) (int64, error) {
	var result sql.Result
	var err error
	switch v := any(*ent).(type) {
	default:
		log.Fatal("Not supported")
	case Company:
		fmt.Printf("Company: %v\n", v.Name)
		result, err = db.Exec(
			`INSERT INTO company
			(Name, Country, YearFound, EmployeeCount)
			VALUES (?, ?, ?, ?, ?)`,
			v.Name, v.Country, v.YearFound, v.EmployeeCount,
		)
	case Applicant:
		result, err = db.Exec(
			`INSERT INTO applicant
			(Name, Age, Education, University, Graduated, Specialty, Level, Experience, WorkHistory)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
			v.Name, v.Age, v.Education, v.University, v.Graduated,
			v.Specialty, v.Level, v.Experience, v.WorkHistory,
		)
	case Vacancy:
		result, err = db.Exec(
			`INSERT INTO vacancy
			(Title, Description, CompanyID, Experience, Salary,
			Hours, Employment, Location) 
			VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
			v.Title, v.Description, v.CompanyID, v.Experience, v.Salary,
			v.Hours, v.Employment, v.Location,
		)
	case Language:
		result, err = db.Exec("INSERT INTO language (Name) VALUES (?)", v.Name)
	case Technology:
		result, err = db.Exec("INSERT INTO technology (Name) VALUES (?)", v.Name)
	}
	if err != nil {
		return 0, fmt.Errorf("insertSql: %v", err)
	}
	id, err := result.LastInsertId()
	if err != nil {
		return 0, fmt.Errorf("insertSql: %v", err)
	}
	return id, nil
}

func connectToDB() *sqlx.DB {
	cfg := mysql.NewConfig()
	cfg.User = os.Getenv("DBUSER")
	cfg.Passwd = os.Getenv("DBPASS")
	cfg.Net = "unix"
	cfg.Addr = "/var/lib/mysql/mysql.sock"
	cfg.DBName = "bbtkru"

	// Get a database handle.
	db, err := sqlx.Connect("mysql", cfg.FormatDSN())
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("Connection successfull!")
	return db
}

func populateDB(db *sqlx.DB) {
	var languages []Language
	readJSON(&languages)
	bulkInsertSql(db, languages)
	return
}
