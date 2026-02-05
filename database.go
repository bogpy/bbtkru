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
			VALUES (:Name, :Country, :YearFound, :EmployeeCount)`
	case Applicant:
		query = `INSERT INTO applicant
			(Name, DateOfBirth, Education, University, Graduated, Specialty, Level, Experience, WorkHistory)
			VALUES (:Name, :DateOfBirth, :Education, :University, :Graduated, :Specialty, :Level, :Experience, :WorkHistory)`
	case Vacancy:
		query = `INSERT INTO vacancy
			(Title, Description, CompanyID, Experience, Salary,
			Hours, Employment, Location) 
			VALUES (:Title, :Description, :CompanyID, :Experience, :Salary, :Hours, :Employment, :Location)`
	case Language:
		query = `INSERT INTO language (Name) VALUES (:Name)`
	case Technology:
		query = `INSERT INTO technology (Name) VALUES (:Name)`
	}
	// query, args, err := sqlx.In(query, arr)
	// if err != nil {
	// 	fmt.Errorf("bulkInsertSql: %v", err)
	// }
	fmt.Println(query)
	fmt.Printf("%v\n", len(arr))
	_, err := db.NamedExec(query, arr)
	if err != nil {
		fmt.Errorf("bulkInsertSql: %v", err)
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
			(Name, Education, University, Graduated, Specialty, Level, Experience, WorkHistory)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
			v.Name, v.Education, v.University, v.Graduated,
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

func emptyDB(db *sqlx.DB) {

}

func populateDB(db *sqlx.DB) {
	var languages []Language
	readJSON(&languages)
	bulkInsertSql(db, languages)

	var technologies []Technology
	readJSON(&technologies)
	bulkInsertSql(db, technologies)

	var companies []Company
	readJSON(&companies)
	bulkInsertSql(db, companies)

	var applicants []Applicant
	readJSON(&applicants)
	bulkInsertSql(db, applicants)

	var vacancies []Vacancy
	readJSON(&vacancies)
	good_vacancies := vacancies[:0]
	for _, vacancy := range vacancies {
		company, err := getCompany(db, &vacancy.CompanyName, nil)
		if err != nil {
			log.Printf("Company name %v not found", vacancy.CompanyName)
		} else {
			vacancy.CompanyID = company.ID
			// fmt.Printf("Vacancy %v, from company %v with id %v\n", 
			// 		vacancy.Title, vacancy.CompanyName, vacancy.CompanyID)
			good_vacancies = append(good_vacancies, vacancy)
		}
	}
	fmt.Printf("number of good vacancies: %v", len(good_vacancies))
	bulkInsertSql(db, good_vacancies)
}
