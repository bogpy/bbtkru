package main

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/jmoiron/sqlx"
    "github.com/go-sql-driver/mysql"
	"log"
	"os"
)

type EducationType string
const (
	HighSchool EducationType = "High School"
	Bachelor EducationType = "Bachelor"
	Master EducationType = "Master"
	PhD EducationType = "PhD"
)

type SpecialtyType string
const (
	Frontend SpecialtyType = "Frontend"
	Backend SpecialtyType = "Backend"
	Fullstack SpecialtyType = "Fullstack"
	DataEngineer SpecialtyType = "DataEngineer"
	DevOps SpecialtyType = "DevOps"
)

type LevelType string
const (
	Intern LevelType = "Level"
	Junior LevelType = "Junior"
	Middle LevelType = "Middle"
	Senior LevelType = "Senior"
	Lead LevelType = "Lead"
)

type EmploymentType string
const (
	Internship EmploymentType = "Internship"
	FullTime EmploymentType = "Full-time"
	PartTime EmploymentType = "Part-time"
)

type LocationType string
const (
	Remote LocationType = "Remote"
	Hybrid LocationType = "Hybrid"
	InOffice LocationType = "In-office"
)

type Language struct {
	ID			int
	Name		string
}

type Technology struct {
	ID			int
	Name		string
}

type Vacancy struct {
	ID			int
	Title       string
	Description string
	CompanyID   int
	Experience  int
	Salary      int
	Hours       int
	Employment	EmploymentType
	Location	LocationType
}

type Company struct {
	ID            int
	Name          string
	Country       string
	YearFound     int //foundation year
	EmployeeCount int
}

type Applicant struct {
	ID           int
	Name         string
	Age          int
	Education    EducationType
	University   string
	Graduated    bool
	Specialty    SpecialtyType // backend frontend fullstack
	Level        LevelType
	Experience   int
	WorkHistory	 string
	Score        int
}

func readJSON[T any](arr *[]T) {
	var el T
	path := fmt.Sprintf("data/%T.json", el)
	file, err := os.Open(path)
	if err != nil {
		fmt.Printf("No such file: %v\n", path)
		return
	}
	defer file.Close()
	decoder := json.NewDecoder(file)
	err = decoder.Decode(arr)
	if err != nil {
		fmt.Printf("JSON error: %v\n", err)
		var typeErr *json.UnmarshalTypeError
		if errors.As(err, &typeErr) {
			fmt.Printf("❌ Type Mismatch!\n")
			fmt.Printf("Key: %s\n", typeErr.Field)
			fmt.Printf("Provided Value: %s\n", typeErr.Value) // This is the "bad" string
			fmt.Printf("Expected Type: %v\n", typeErr.Type)
			fmt.Printf("Location in JSON: byte %d\n", typeErr.Offset)
		}
	}
}

func insertSql[T any](ent *T) (int64, error) {
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
			v.Name, v.Country, v.YearFound, v.EmployeeCount
		)
	case Applicant:
		result, err = db.Exec(
			`INSERT INTO applicant
			(Name, Age, Education, University, Graduated, Specialty, Level, Experience, WorkHistory)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
		 	v.Name, v.Age, v.Education, v.University, v.Graduated, v.Specialty v.Level, v.Experience, v.WorkHistory
		)
	case Vacancy:
		result, err = db.Exec(
			`INSERT INTO vacancy
			(Title, Description, CompanyID, Experience, Salary, Hours, Employment, Location) 
			VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
			v.Title, v.Description, v.CompanyID, v.Experience, v.Salary, v.Hours, v.Employment, v.Location
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

func searchSqlBy(experience string) ([]Applicant, error) {
	var applicants []Applicant
	rows, err := db.Query("SELECT * FROM applicant WHERE experience = ?", experience)

	if err != nil {
		return nil, fmt.Errorf("searchSqlBy %q: %v", experience, err)
	}
	defer rows.Close()

	for rows.Next() {
		var app Applicant
		if err := rows.Scan(&app.Name, &app.Age, &app.Experience, &app.University, &app.Level, &app.Graduated, &app.Companies, &app.Education, &app.Specialty, &app.Languages, &app.Technologies); err != nil {
			return nil, fmt.Errorf("searchSqlBy %q: %v", experience, err)
		}
		applicants = append(applicants, app)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("searchSqlBy %q: %v", experience, err)
	}
	return applicants, nil
}


func connectToDB() (*sqlx.DB) {
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

func populateDB() {
	var languages []Language
	readJSON(&languages)
	for _, language := range languages {
		id, _ := insertSql(&language)
		fmt.Printf("Last inserted id: %v\n", id)
	}
	return

	// var companies []Company
	// var applicants []Applicant
	// var vacancies []Vacancy
	// readJSON(&vacancies)
	// readJSON(&applicants)
	// readJSON(&companies)

	// for _, comp := range companies {
	// 	id, _ := insertSql(&comp)
	// 	fmt.Printf("Last inserted id: %v\n", id)
	// }
}

var db *sqlx.DB

func main() {
	db = connectToDB()
	defer db.Close()
	populateDB()
}
