package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

func connectDB() *sqlx.DB {
	fmt.Print("Connecting to database...")
	dsn := os.Getenv("SQLX_MYSQL_DSN")
	db := sqlx.MustConnect("mysql", dsn)
	fmt.Println("Success!")
	return db
}

func initDB(db *sqlx.DB) {
	fmt.Print("Initializing database...")
	schema := `
		DROP TABLE IF EXISTS applicant_language;
		DROP TABLE IF EXISTS applicant_technology;
		DROP TABLE IF EXISTS vacancy_language;
		DROP TABLE IF EXISTS vacancy_technology;
		DROP TABLE IF EXISTS language;
		DROP TABLE IF EXISTS technology;
		DROP TABLE IF EXISTS applicant;
		DROP TABLE IF EXISTS vacancy;
		DROP TABLE IF EXISTS company;

		CREATE TABLE applicant (
			ID				INT AUTO_INCREMENT NOT NULL,
			Name			VARCHAR(100) NOT NULL,
			DateOfBirth		DATE,
			Education		ENUM('High School', 'Bachelor', 'Master', 'PhD'),
			University		VARCHAR(100),
			Graduated		BOOL,
			Specialty		ENUM('Frontend', 'Backend', 'Fullstack', 'Data Engineer', 'DevOps'),
			Level			ENUM('Intern', 'Junior', 'Middle', 'Senior', 'Lead'),
			Experience		INT,
			WorkHistory		TEXT,
			PRIMARY KEY (ID)
		);

		CREATE TABLE company (
			ID				INT AUTO_INCREMENT NOT NULL,
			Name			VARCHAR(100) NOT NULL UNIQUE,
			Country			VARCHAR(50),
			YearFound		INT,
			EmployeeCount	INT,
			PRIMARY KEY (ID)
		);

		CREATE TABLE vacancy (
			ID				INT AUTO_INCREMENT NOT NULL,
			Title			VARCHAR(100) NOT NULL,
			Description		TEXT,
			CompanyID		INT NOT NULL,
			Experience		INT,
			Salary			INT,
			Hours			INT,
			Employment		ENUM('Internship', 'Full-time', 'Part-time'),
			Location		ENUM('Remote', 'Hybrid', 'In-office'),
			PRIMARY KEY (ID),
			FOREIGN KEY (CompanyID) REFERENCES company(ID) ON DELETE CASCADE
		);

		CREATE TABLE language (
			ID				INT AUTO_INCREMENT NOT NULL,
			Name			VARCHAR(50) NOT NULL UNIQUE,
			PRIMARY KEY(ID)
		);

		CREATE TABLE technology (
			ID				INT AUTO_INCREMENT NOT NULL,
			Name			VARCHAR(50) NOT NULL UNIQUE,
			PRIMARY KEY(ID)
		);

		CREATE TABLE applicant_language (
			applicant_id	INT,
			language_id		INT,

			FOREIGN KEY (applicant_id) REFERENCES applicant(ID) ON DELETE CASCADE,
			FOREIGN KEY (language_id) REFERENCES language(ID) ON DELETE CASCADE,

			PRIMARY KEY (applicant_id, language_id)
		);


		CREATE TABLE applicant_technology (
			applicant_id	INT,
			technology_id	INT,

			FOREIGN KEY (applicant_id) REFERENCES applicant(ID) ON DELETE CASCADE,
			FOREIGN KEY (technology_id) REFERENCES technology(ID) ON DELETE CASCADE,

			PRIMARY KEY (applicant_id, technology_id)
		);

		CREATE TABLE vacancy_language (
			vacancy_id	INT,
			language_id		INT,

			FOREIGN KEY (vacancy_id) REFERENCES vacancy(ID) ON DELETE CASCADE,
			FOREIGN KEY (language_id) REFERENCES language(ID) ON DELETE CASCADE,

			PRIMARY KEY (vacancy_id, language_id)
		);


		CREATE TABLE vacancy_technology (
			vacancy_id	INT,
			technology_id	INT,

			FOREIGN KEY (vacancy_id) REFERENCES vacancy(ID) ON DELETE CASCADE,
			FOREIGN KEY (technology_id) REFERENCES technology(ID) ON DELETE CASCADE,

			PRIMARY KEY (vacancy_id, technology_id)
		);`
	db.MustExec(schema)
	fmt.Println("Success!")
}

func populateDB(db *sqlx.DB) {
	var languages []*Language
	fmt.Print("Populating database from json backups...")
	if err := readJSON(&languages); err != nil {
		log.Fatal(err)
	}
	if err := bulkInsertSql(db, languages); err != nil {
		log.Fatal(err)
	}

	language_ids := make(map[string]int64)
	for _, lang := range languages {
		language_ids[lang.Name] = lang.ID
	}

	var technologies []*Technology
	if err := readJSON(&technologies); err != nil {
		log.Fatal(err)
	}
	if err := bulkInsertSql(db, technologies); err != nil {
		log.Fatal(err)
	}

	technology_ids := make(map[string]int64)
	for _, tech := range technologies {
		technology_ids[tech.Name] = tech.ID
	}

	var companies []*Company
	if err := readJSON(&companies); err != nil {
		log.Fatal(err)
	}
	if err := bulkInsertSql(db, companies); err != nil {
		log.Fatal(err)
	}

	company_ids := make(map[string]int64)
	for _, comp := range companies {
		company_ids[comp.Name] = comp.ID
	}

	var applicants []*Applicant
	if err := readJSON(&applicants); err != nil {
		log.Fatal(err)
	}
	if err := bulkInsertSql(db, applicants); err != nil {
		log.Fatal(err)
	}

	if err := insertJunction(db, applicant, language_ids, technology_ids); err != nil {
		log.Fatal(err)
	}

	var vacancies []*Vacancy
	if err := readJSON(&vacancies); err != nil {
		log.Fatal(err)
	}

	good_vacancies := vacancies[:0]
	for _, vacancy := range vacancies {
		compID, ok := company_ids[vacancy.CompanyName]
		if ok {
			vacancy.CompanyID = compID
			good_vacancies = append(good_vacancies, vacancy)
		} else {
			log.Printf("Vacancy %v doesnt have company", vacancy.Title)
		}
	}

	if err := bulkInsertSql(db, vacancies); err != nil {
		log.Fatal(err)
	}

	if err := insertJunction(db, applicant, language_ids, technology_ids); err != nil {
		log.Fatal(err)
	}
	fmt.Println("Success!")
}

func insertJunction[T any](db *sqlx.DB, arr []*T, map[string]int64, map[string]int64) {
	var query string
	var el T
	switch any(el).(type) {
	default:
		return fmt.Errorf(
			"SQL insert not supported for %T: %w",
			el,
			ErrNotSupported,
		)
	case A:
	}
}

// INSERT INTO applicat_technology (applicant_id, technology_id) VALUES (?, ?)

// TODO: rewrite similar to bulkInsertSql
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

func bulkInsertSql[T ID_setter](db *sqlx.DB, arr []T) error {
	var query string
	var el T
	switch any(el).(type) {
	default:
		return fmt.Errorf(
			"SQL insert not supported for %T: %w",
			el,
			ErrNotSupported,
		)
	case *Company:
		query = `INSERT INTO company
			(Name, Country, YearFound, EmployeeCount)
			VALUES (:Name, :Country, :YearFound, :EmployeeCount)`
	case *Applicant:
		query = `INSERT INTO applicant
			(Name, DateOfBirth, Education, University, Graduated, Specialty, Level, Experience, WorkHistory)
			VALUES (:Name, :DateOfBirth, :Education, :University, :Graduated, :Specialty, :Level, :Experience, :WorkHistory)`
	case *Vacancy:
		query = `INSERT INTO vacancy
			(Title, Description, CompanyID, Experience, Salary,
			Hours, Employment, Location) 
			VALUES (:Title, :Description, :CompanyID, :Experience, :Salary, :Hours, :Employment, :Location)`
	case *Language:
		query = `INSERT INTO language (Name) VALUES (:Name)`
	case *Technology:
		query = `INSERT INTO technology (Name) VALUES (:Name)`
	}
	// query, args, err := sqlx.In(query, arr)
	// if err != nil {
	// 	fmt.Errorf("bulkInsertSql: %v", err)
	// }
	tx := db.MustBegin()
	res, err := tx.NamedExec(query, arr)
	if err != nil {
		tx.Rollback()
		return err
	}
	tx.Commit()
	id, err := res.LastInsertId()
	if err != nil {
		return err
	}

	for _, ent := range arr {
		ent.set_ID(id)
		id += 1
	}
	return nil
}
