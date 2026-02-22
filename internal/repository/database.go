package repository

import (
	"fmt"
	"log"
	"os"

	"github.com/bogpy/bbtkru/internal/models"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

func NamedExecWrapper [T IdSetter] (db *sqlx.DB, query string, arr []T) error {
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
	lr := NewLanguageRepository(db)
	if err := lr.BulkInsert(languages); err != nil {
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
	tr := NewTechnologyRepository(db)
	if err := tr.BulkInsert(technologies); err != nil {
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
	cr := NewCompanyRepository(db)
	if err := cr.BulkInsert(companies); err != nil {
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
	ar := NewApplicantRepository(db)
	if err := ar.BulkInsert(applicants); err != nil {
		log.Fatal(err)
	}

	if err := ar.InsertJunction(applicants, language_ids, technology_ids); err != nil {
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
			log.Printf("Vacancy %v doesn't have company", vacancy.Title)
		}
	}
	vr := NewVacancytRepository(db)
	if err := vr.BulkInsert(good_vacancies); err != nil {
		log.Fatal(err)
	}

	if err := vr.InsertJunction(good_vacancies, language_ids, technology_ids); err != nil {
		log.Fatal(err)
	}
	fmt.Println("Success!")
}