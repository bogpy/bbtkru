package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"log"
	"database/sql"
	"github.com/go-sql-driver/mysql"
)

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
	switch v := ent.(type) {
	default:
		log.Fatal("Not supported")
	case Company:
		result, err := db.Exec("INSERT INTO company (Name, Country, YearFound, EmployeeCount, Vacancies) VALUES (?, ?, ?, ?, ?)", v.Name, v.Country, v.YearFound, v.EmployeeCount, v.Vacancies)
	case Applicant:
		result, err := db.Exec("INSERT INTO applicant (Name, Age, Experience, University, Level, Graduated, Companies, Education, Specialty, Languages, Technologies, Score) VALUES (?, ?, ?, ?, ?)", v.Name, v.Age, v.Experience, v.Univesity, v.Level, v.Graduated, v.Companies, v.Education, v.Specialty, v.Languages, v.Technologies, v.Score)
	case Vacancy:
		result, err := db.Exec("INSERT INTO vacancy (Title, Description, Company, Experience, Type, Salary, Hours) VALUES (?, ?, ?, ?, ?)", v.Title, v.Description, v.Company, v.Experience, v.Type, v.Salary, v.Hours)
	}
	_, err := query.Exec(table, )
    if err != nil {
        return 0, fmt.Errorf("addAlbum: %v", err)
    }
    id, err := result.LastInsertId()
    if err != nil {
        return 0, fmt.Errorf("addAlbum: %v", err)
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
        if err := rows.Scan(&app.Name, &app.Age, &app.Experience, &app.University, &app.Level, &app.Graduated, &app.Companies, &app.Education, &app.Specialty, &app.Languages, &app.Technologies, &app.Score); err != nil {
            return nil, fmt.Errorf("searchSqlBy %q: %v", name, err)
        }
        applicants = append(applicants, app)
    }
    if err := rows.Err(); err != nil {
        return nil, fmt.Errorf("searchSqlBy %q: %v", name, err)
    }
    return applicants, nil
}

var db *sql.DB

func main() {
	var companies []Company
	var applicants []Applicant
	var vacancies []Vacancy
	readJSON(vacancies)
	readJSON(applicants)
	readJSON(companies)
	// Capture connection properties.
    cfg := mysql.NewConfig()
    cfg.User = os.Getenv("DBUSER")
    cfg.Passwd = os.Getenv("DBPASS")
    cfg.Net = "unix"
    cfg.Addr = "/var/lib/mysql/mysql.sock"
    cfg.DBName = "bbtkru"

    // Get a database handle.
    db, err := sql.Open("mysql", cfg.FormatDSN())
    if err != nil {
        log.Fatal(err)
    }

    pingErr := db.Ping()
    if pingErr != nil {
        log.Fatal(pingErr)
    }
    fmt.Println("Connected!")

	for _, comp := range companies {
		insertSql(&comp)
	}

}
