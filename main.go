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

type Vacancy struct {
	Title       string
	Description string
	Company     string
	CompanyID   int
	Experience  int
	Type        int8 //remote inoffice outoffice
	Salary      int
	Hours       int
}

type Company struct {
	ID            int
	Name          string
	Country       string
	YearFound     int //foundation year
	EmployeeCount int
	Vacancies     []*Vacancy
}

type Applicant struct {
	ID           int
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

func readJSON[T any](arr []T) {
	var el T
	path := fmt.Sprintf("data/%T.json", el)
	file, err := os.Open(path)
	if err != nil {
		fmt.Printf("No such file: %v\n", path)
		return
	}
	defer file.Close()
	decoder := json.NewDecoder(file)
	err = decoder.Decode(&arr)
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
	fmt.Println(len(arr))
	// for _, comp := range arr {
	// 	// fmt.Println(comp)
	// }
}

func insertSql[T any](ent *T) (int, error) {
	var result sql.Result
	var err error
	switch v := any(ent).(type) {
	default:
		log.Fatal("Not supported")
	case Company:
		result, err = db.Exec("INSERT INTO company (Name, Country, YearFound, EmployeeCount, Vacancies) VALUES (?, ?, ?, ?, ?)", v.Name, v.Country, v.YearFound, v.EmployeeCount, v.Vacancies)
	case Applicant:
		result, err = db.Exec("INSERT INTO applicant (Name, Age, Experience, University, Level, Graduated, Companies, Education, Specialty, Languages, Technologies) VALUES (?, ?, ?, ?, ?)", v.Name, v.Age, v.Experience, v.University, v.Level, v.Graduated, v.Companies, v.Education, v.Specialty, v.Languages, v.Technologies)
	case Vacancy:
		result, err = db.Exec("INSERT INTO vacancy (Title, Description, Company, Experience, Type, Salary, Hours) VALUES (?, ?, ?, ?, ?)", v.Title, v.Description, v.Company, v.Experience, v.Type, v.Salary, v.Hours)
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
	var albums []Applicant
	rows, err := db.Query("SELECT * FROM applicant WHERE experience = ?", experience)

	if err != nil {
		return nil, fmt.Errorf("searchSqlBy %q: %v", name, err)
	}
	defer rows.Close()

	for rows.Next() {
		var app Applicant
		if err := rows.Scan(&app.Name, &app.Age, &app.Experience, &app.University, &app.Level, &app.Graduated, &app.Companies, &app.Education, &app.Specialty, &app.Languages, &app.Technologies); err != nil {
			return nil, fmt.Errorf("searchSqlBy %q: %v", name, err)
		}
		applicants = append(applicants, app)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("searchSqlBy %q: %v", name, err)
	}
	return applicants, nil
}

var db *sqlx.DB

func connectToDB() (*sqlx.DB, error) {
	cfg := mysql.NewConfig{
		User: os.Getenv("DBUSER")
		Passwd: os.Getenv("DBPASS")
		Net: "unix"
		Addr: "/var/lib/mysql/mysql.sock"
		DBName: "bbtkru"
		AllowNativePasswords: true, // Recommended for modern MySQL versions.
        ParseTime:            true,
        Collation:            "utf8mb4_unicode_ci",
        Loc:                  time.Local, // Use the system's local time zone.
        Timeout:              5 * time.Second,
        ReadTimeout:          30 * time.Second,
        WriteTimeout:         30 * time.Second,
	}

	// Get a database handle.
	db, err := sqlx.Connect("mysql", cfg.FormatDSN())
	if err != nil {
		log.Fatal(err)
	}
	
}

func main() {
	var companies []Company
	var applicants []Applicant
	var vacancies []Vacancy
	readJSON(vacancies)
	readJSON(applicants)
	readJSON(companies)
	
	db = connectToDB()
	defer db.Close()

	for _, comp := range companies {
		insertSql(&comp)
	}

}
