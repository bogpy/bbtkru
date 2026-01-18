DROP TABLE IF EXISTS applicant_language;
DROP TABLE IF EXISTS applicant_technology;
DROP TABLE IF EXISTS language;
DROP TABLE IF EXISTS technology;
DROP TABLE IF EXISTS applicant;
DROP TABLE IF EXISTS vacancy;
DROP TABLE IF EXISTS company;

CREATE TABLE applicant (
	ID				INT AUTO_INCREMENT NOT NULL,
	Name			VARCHAR(100) NOT NULL,
	Age				INT,
	Education		ENUM('High School', 'Bachelor', 'Master', 'PhD'),
	University		VARCHAR(100),
	Graduated		BOOL,
	Specialty		ENUM('Frontend', 'Backend', 'Fullstack', 'Data Engineer', 'DevOps'),
	Level			ENUM('Intern', 'Junior', 'Middle', 'Senior', 'Lead'),
	Experience		INT,
	WorkHistory		VARCHAR(200),
	PRIMARY KEY (`ID`)
);

CREATE TABLE company (
	ID				INT AUTO_INCREMENT NOT NULL,
	Name			VARCHAR(100) NOT NULL,
	Country			VARCHAR(50),
	YearFound		INT,
	EmployeeCount	INT,
	PRIMARY KEY (`ID`)
);

CREATE TABLE vacancy (
	ID				INT AUTO_INCREMENT NOT NULL,
	Title			VARCHAR(100) NOT NULL,
	Description		VARCHAR(200),
	CompanyID		INT NOT NULL,
	Experience		INT,
	Salary			INT,
	Hours			INT,
	Employment		ENUM('Internship', 'Full-time', 'Part-time'),
	Location		ENUM('Remote', 'Hybrid', 'In-office'),
	PRIMARY KEY (`ID`),
	FOREIGN KEY (CompanyID) REFERENCES company(ID) ON DELETE CASCADE
);

CREATE TABLE language (
	ID				INT AUTO_INCREMENT NOT NULL,
	Name			VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY(`ID`)
);

CREATE TABLE technology (
	ID				INT AUTO_INCREMENT NOT NULL,
	Name			VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY(`ID`)
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
