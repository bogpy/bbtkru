package main

import (
	"database/sql"
	"fmt"
	"strings"
)

type Company struct {
	ID            int `db:"ID"`
	Name          string `db:"Name"`
	Country       string `db:"Country"`
	YearFound     int `db:"YearFound"`//foundation year
	EmployeeCount int `db:"EmployeeCount"`
	Score         int
}

type RequestForCompany struct {
	Country			string
	EmployeeCount  *int
}

func getCompany(db *sql.DB, name string, id int) (Company, error) {
	
	if name != nill {
		row, err = db.QueryRowx(
			"SELECT * FROM company WHERE (Name) = (?)",
			name
		)
	}
	else if id != nil {
		row, err = db.QueryRowx(
			"SELECT * FROM company WHERE (ID) = (?)",
			name
		)
	}
	if err != nil {
		return nil, err
	}
	// method get sqlx
	var c Company
	if err = row.StructScan(&c); err != nil{
		return nil, err
	}
	return c, row.Err()
}

func getCompanies(db *sql.DB, request RequestForCompany) ([]Company, error) {
	var queryBuilder strings.Builder
	queryBuilder.WriteString("SELECT * FROM company WHERE 1=1")
	var args []interface{}

	if request.EmployeeCount != nil {
		queryBuilder.WriteString("AND EmployeeCount >= ?")
		args = append(args, *request.EmployeeCount)
	}

	if request.Country != nil {
		queryBuilder.WriteString("AND Country = ?")
		args = append(args, *request.Country)
	}

	query := queryBuilder.String()
	rows, err := db.Query(query, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var companies []Company
	for rows.Next() {
		var c Company
		if err := rows.Scan(&c.Name, &c.Country, &c.YearFound, &c.EmployeeCount); err != nil {
			return nil, err
		}
		companies = append(companies, c)
	}
	return companies, rows.Err()
}

func deleteCompany(db *sql.DB, ID int) error {
	result, err := db.Exec("DELETE FROM company WHERE ID = ?", ID)
	if err != nil {
		return err
	}
	count, err := result.RowsAffected()
	if err != nil {
		return err
	}
	if count == 0 {
		return fmt.Errorf("Company with id %d not found", ID)
	}

	result, err = db.Exec("DELETE FROM vacancy WHERE CompanyID = ?", ID)
	if err != nil {
		return err
	}
	count, err = result.RowsAffected()
	if err != nil {
		return err
	}

	return nil
}

const (
	RevWeight      = 50
	EmployeeWeight = 25
)

func (x Company) CalcScore(r RequestForCompany) {
	x.Score = 0
	// x.Score += x.RevenuePerYear * RevWeight
	x.Score += x.EmployeeCount * EmployeeWeight
}
