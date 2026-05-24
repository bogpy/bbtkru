DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS applicant_language;
DROP TABLE IF EXISTS applicant_technology;
DROP TABLE IF EXISTS vacancy_language;
DROP TABLE IF EXISTS vacancy_technology;
DROP TABLE IF EXISTS language;
DROP TABLE IF EXISTS technology;
DROP TABLE IF EXISTS applicant;
DROP TABLE IF EXISTS vacancy;
DROP TABLE IF EXISTS company;

CREATE TABLE user (
	id				INT AUTO_INCREMENT NOT NULL,
	name			VARCHAR(100) NOT NULL UNIQUE,
	password		VARCHAR(255) NOT NULL,
	type			ENUM('Company', 'Applicant', 'Admin'),
	PRIMARY KEY (id)
);

CREATE TABLE applicant (
	id				INT AUTO_INCREMENT NOT NULL,
	name			VARCHAR(100) NOT NULL,
	dateOfBirth		DATE,
	education		ENUM('HighSchool', 'Bachelor', 'Master', 'PhD'),
	university		VARCHAR(100),
	graduated		BOOL,
	specialty		ENUM('Frontend', 'Backend', 'Fullstack', 'DataEngineer', 'DevOps'),
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

