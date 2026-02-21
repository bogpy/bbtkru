package repository

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	"github.com/bogpy/bbtkru/internal/models"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

type IdSetter interface {
	SetID(int64)
}

type IdGetter interface {
	GetID() int64
}

type LanguageGetter interface {
	GetLanguages() []models.Language
}

type TechnologyGetter interface {
	GetTechnologies() []models.Technology
}

func ConnectDB() *sqlx.DB {
	fmt.Print("Connecting to database...")
	dsn := os.Getenv("SQLX_MYSQL_DSN")
	db := sqlx.MustConnect("mysql", dsn)
	fmt.Println("Success!")
	return db
}

func InitDB(db *sqlx.DB) {
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
			id				INT AUTO_INCREMENT NOT NULL,
			name			VARCHAR(100) NOT NULL,
			dateOfBirth		DATE,
			education		ENUM('High School', 'Bachelor', 'Master', 'PhD'),
			university		VARCHAR(100),
			graduated		BOOL,
			specialty		ENUM('Frontend', 'Backend', 'Fullstack', 'Data Engineer', 'DevOps'),
			level			ENUM('Intern', 'Junior', 'Middle', 'Senior', 'Lead'),
			experience		INT,
			workHistory		TEXT,
			PRIMARY KEY (id)
		);

		CREATE TABLE company (
			id				INT AUTO_INCREMENT NOT NULL,
			name			VARCHAR(100) NOT NULL UNIQUE,
			country			VARCHAR(50),
			yearFound		INT,
			employeeCount	INT,
			PRIMARY KEY (id)
		);

		CREATE TABLE vacancy (
			id				INT AUTO_INCREMENT NOT NULL,
			title			VARCHAR(100) NOT NULL,
			description		TEXT,
			companyID		INT NOT NULL,
			experience		INT,
			salary			INT,
			hours			INT,
			employment		ENUM('Internship', 'Full-time', 'Part-time'),
			location		ENUM('Remote', 'Hybrid', 'In-office'),
			PRIMARY KEY (id),
			FOREIGN KEY (companyID) REFERENCES company(id) ON DELETE CASCADE
		);

		CREATE TABLE language (
			id				INT AUTO_INCREMENT NOT NULL,
			name			VARCHAR(50) NOT NULL UNIQUE,
			PRIMARY KEY(id)
		);

		CREATE TABLE technology (
			id				INT AUTO_INCREMENT NOT NULL,
			name			VARCHAR(50) NOT NULL UNIQUE,
			PRIMARY KEY(id)
		);

		CREATE TABLE applicant_language (
			applicant_id	INT,
			language_id		INT,

			FOREIGN KEY (applicant_id) REFERENCES applicant(id) ON DELETE CASCADE,
			FOREIGN KEY (language_id) REFERENCES language(id) ON DELETE CASCADE,

			PRIMARY KEY (applicant_id, language_id)
		);


		CREATE TABLE applicant_technology (
			applicant_id	INT,
			technology_id	INT,

			FOREIGN KEY (applicant_id) REFERENCES applicant(id) ON DELETE CASCADE,
			FOREIGN KEY (technology_id) REFERENCES technology(id) ON DELETE CASCADE,

			PRIMARY KEY (applicant_id, technology_id)
		);

		CREATE TABLE vacancy_language (
			vacancy_id	INT,
			language_id		INT,

			FOREIGN KEY (vacancy_id) REFERENCES vacancy(id) ON DELETE CASCADE,
			FOREIGN KEY (language_id) REFERENCES language(id) ON DELETE CASCADE,

			PRIMARY KEY (vacancy_id, language_id)
		);


		CREATE TABLE vacancy_technology (
			vacancy_id	INT,
			technology_id	INT,

			FOREIGN KEY (vacancy_id) REFERENCES vacancy(id) ON DELETE CASCADE,
			FOREIGN KEY (technology_id) REFERENCES technology(id) ON DELETE CASCADE,

			PRIMARY KEY (vacancy_id, technology_id)
		);`
	db.MustExec(schema)
	fmt.Println("Success!")
}

func PopulateDB(db *sqlx.DB) {
	fmt.Print("Populating database from json backups...")
	fsys := os.DirFS("./data/json")
	languages, err := ReadJSON[*models.Language](fsys)
	if err != nil {
		log.Fatal(err)
	}
	if err := BulkInsertSql(db, languages); err != nil {
		log.Fatal(err)
	}

	language_ids := make(map[string]int64)
	for _, lang := range languages {
		language_ids[lang.Name] = lang.ID
	}

	technologies, err := ReadJSON[*models.Technology](fsys)
	if err != nil {
		log.Fatal(err)
	}
	if err := BulkInsertSql(db, technologies); err != nil {
		log.Fatal(err)
	}

	technology_ids := make(map[string]int64)
	for _, tech := range technologies {
		technology_ids[tech.Name] = tech.ID
	}

	companies, err := ReadJSON[*models.Company](fsys)
	if err != nil {
		log.Fatal(err)
	}
	if err := BulkInsertSql(db, companies); err != nil {
		log.Fatal(err)
	}

	company_ids := make(map[string]int64)
	for _, comp := range companies {
		company_ids[comp.Name] = comp.ID
	}

	applicants, err := ReadJSON[*models.Applicant](fsys)
	if err != nil {
		log.Fatal(err)
	}
	if err := BulkInsertSql(db, applicants); err != nil {
		log.Fatal(err)
	}

	if err := InsertJunction(db, applicants, language_ids, technology_ids); err != nil {
		log.Fatal(err)
	}

	vacancies, err := ReadJSON[*models.Vacancy](fsys)
	if err != nil {
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

	if err := BulkInsertSql(db, good_vacancies); err != nil {
		log.Fatal(err)
	}

	if err := InsertJunction(db, good_vacancies, language_ids, technology_ids); err != nil {
		log.Fatal(err)
	}
	fmt.Println("Success!")
}

type Custom interface {
	IdGetter
	LanguageGetter
	TechnologyGetter
}

func InsertJunction[T Custom](db *sqlx.DB, arr []T, language_ids map[string]int64, technology_ids map[string]int64) error {
	var query1, query2 string
	var el T
	switch any(el).(type) {
	default:
		return fmt.Errorf(
			"SQL insert not supported for %T: %w",
			el,
			models.ErrNotSupported,
		)
	case *models.Applicant:
		query1 = `INSERT INTO applicant_language al
				 (applicant_id, language_id)
				 VALUES (?, ?)
				`
		query2 = `INSERT INTO applicant_technology at
					(applicant_id, technology_id)
					VALUES (?, ?)
				`
	case *models.Vacancy:
		query1 = `INSERT INTO vacancy_language cl
				 (vacancy_id, language_id)
					VALUES (?, ?)
				`
		query2 = `INSERT INTO vacancy_technology vt
				 (vacancy_id, technology_id)
				  VALUES (?, ?)
				`
	}

	var args []
	for _, ent := range arr {
		for _, lang := range ent.GetLanguages(){
			args = append(args, [2]int64{ent.GetID(), language_ids[lang.Name]})
		}
		for _, tech := range ent.GetTechnologies(){
			args = append(args, [2]int64{ent.GetID(), technology_ids[tech.Name]})
		}
	}

	tx := db.MustBegin()
	_, err := tx.Exec(query1, args)
	if err != nil {
		tx.Rollback()
		return err
	}
	_, err = tx.Exec(query2, args)
	if err != nil {
		tx.Rollback()
		return err
	}
	return nil
}

// INSERT INTO applicant_technology (applicant_id, technology_id) VALUES (?, ?)

// TODO: rewrite similar to bulkInsertSql
func InsertSql[T any](db *sqlx.DB, ent *T) (int64, error) {
	var result sql.Result
	var err error
	switch v := any(*ent).(type) {
	default:
		log.Fatal("Not supported")
	case models.Company:
		fmt.Printf("Company: %v\n", v.Name)
		result, err = db.Exec(
			`INSERT INTO company
			(Name, Country, YearFound, EmployeeCount)
			VALUES (?, ?, ?, ?, ?)`,
			v.Name, v.Country, v.YearFound, v.EmployeeCount,
		)
	case models.Applicant:
		result, err = db.Exec(
			`INSERT INTO applicant
			(Name, Education, University, Graduated, Specialty, Level, Experience, WorkHistory)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
			v.Name, v.Education, v.University, v.Graduated,
			v.Specialty, v.Level, v.Experience, v.WorkHistory,
		)
	case models.Vacancy:
		result, err = db.Exec(
			`INSERT INTO vacancy
			(Title, Description, CompanyID, Experience, Salary,
			Hours, Employment, Location) 
			VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
			v.Title, v.Description, v.CompanyID, v.Experience, v.Salary,
			v.Hours, v.Employment, v.Location,
		)
	case models.Language:
		result, err = db.Exec("INSERT INTO language (Name) VALUES (?)", v.Name)
	case models.Technology:
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

func BulkInsertSql[T IdSetter](db *sqlx.DB, arr []T) error {
	var query string
	var el T
	switch any(el).(type) {
	default:
		return fmt.Errorf(
			"SQL insert not supported for %T: %w",
			el,
			models.ErrNotSupported,
		)
	case *models.Company:
		query = `INSERT INTO company
			(name, country, yearFound, employeeCount)
			VALUES (:name, :country, :yearFound, :employeeCount)`
	case *models.Applicant:
		query = `INSERT INTO applicant
			(name, dateOfBirth, education, university, graduated, specialty, level, experience, workHistory)
			VALUES (:name, :dateOfBirth, :education, :university, :graduated, :specialty, :level, :experience, :workHistory)`
	case *models.Vacancy:
		query = `INSERT INTO vacancy
			(title, description, companyID, experience, salary, hours, employment, location) 
			VALUES (:title, :description, :companyID, :experience, :salary, :hours, :employment, :location)`
	case *models.Language:
		query = `INSERT INTO language (name) VALUES (:name)`
	case *models.Technology:
		query = `INSERT INTO technology (name) VALUES (:name)`
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
		ent.SetID(id)
		id += 1
	}
	return nil
}
