DROP TABLE IF EXISTS applicant;

CREATE TABLE applicant (
	ID				INT AUTO_INCREMENT NOT NULL,
	Name			VARCHAR(100) NOT NULL,
	Age				INT,
	Experience		INT,
	University		VARCHAR(100),
	Level			INT,
	Graduated		BOOL,
	Companies		JSON,
	Education		INT,
	Specialty		VARCHAR(50),
	Languages		JSON,
	Technologies	JSON,
	PRIMARY KEY (`ID`)
);

CREATE TABLE company (
	ID				INT AUTO_INCREMENT NOT NULL,
	Name			VARCHAR(100) NOT NULL,
	Country			VARCHAR(50),
	YearFound		INT,
	EmployeeCount	INT,
	Vacancies		JSON,
	PRIMARY KEY (`ID`)
);

CREATE TABLE vacancy (
	ID				INT AUTO_INCREMENT NOT NULL,
	Title			VARCHAR(100) NOT NULL,
	Description		VARCHAR(200),
	Company			VARCHAR(100) NOT NULL,
	CompanyID		INT NOT NULL,
	Experience		INT,
	Type			INT,
	Salary			INT,
	Hours			INT,
	PRIMARY KEY (`ID`)
);
