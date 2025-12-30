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
		// result, err := db.Exec("INSERT INTO applicant (Name, Country, YearFound, EmployeeCount, Vacancies) VALUES (?, ?, ?, ?, ?)", ent.Name, ent.Country, ent.YearFound, ent.EmployeeCount, ent.Vacancies)
	case Vacancy:
		// result, err := db.Exec("INSERT INTO vacancy (Name, Country, YearFound, EmployeeCount, Vacancies) VALUES (?, ?, ?, ?, ?)", ent.Name, ent.Country, ent.YearFound, ent.EmployeeCount, ent.Vacancies)
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
