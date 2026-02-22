package repository

import (
	"fmt"
	"strings"

	"github.com/bogpy/bbtkru/internal/models"
	"github.com/jmoiron/sqlx"
)

type CompanyRepository struct{
	DB *sqlx.DB
}

func NewCompanyRepository(db *sqlx.DB) *CompanyRepository {
	return &CompanyRepository{DB: db}
}

func (r CompanyRepository) getCompany(name *string, id *int) (models.Company, error) {
	var company models.Company
	var err error
	if name != nil {
		err = r.DB.Get(
			&company,
			"SELECT * FROM company WHERE (name) = (?)",
			*name,
		)
	} else if id != nil {
		err = r.DB.Get(
			&company,
			"SELECT * FROM company WHERE (id) = (?)",
			*id,
		)
	}

	return company, err
}

func (r CompanyRepository) getCompanies(request models.RequestForCompany) ([]models.Company, error) {
	var queryBuilder strings.Builder
	queryBuilder.WriteString("SELECT * FROM company WHERE 1=1")
	var args []interface{}

	if request.EmployeeCount != nil {
		queryBuilder.WriteString("AND employeeCount >= ?")
		args = append(args, *request.EmployeeCount)
	}

	if request.Country != nil {
		queryBuilder.WriteString("AND country = ?")
		args = append(args, *request.Country)
	}

	query := queryBuilder.String()
	rows, err := r.DB.Query(query, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var companies []models.Company
	for rows.Next() {
		var c models.Company
		if err := rows.Scan(&c.Name, &c.Country, &c.YearFound, &c.EmployeeCount); err != nil {
			return nil, err
		}
		companies = append(companies, c)
	}
	return companies, rows.Err()
}

func (r CompanyRepository) deleteCompany(id int) error {
	result, err := r.DB.Exec("DELETE FROM company WHERE id = ?", id)
	if err != nil {
		return err
	}
	count, err := result.RowsAffected()
	if err != nil {
		return err
	}
	if count == 0 {
		return fmt.Errorf("Company with id %d not found", id)
	}

	result, err = r.DB.Exec("DELETE FROM vacancy WHERE CompanyID = ?", id)
	if err != nil {
		return err
	}
	count, err = result.RowsAffected()
	if err != nil {
		return err
	}

	return nil
}

func (r CompanyRepository) BulkInsert(companies []*models.Company) error {
	query := `INSERT INTO company
		(name, country, yearFound, employeeCount)
		VALUES (:name, :country, :yearFound, :employeeCount)`
	return NamedExecWrapper(r.DB, query, companies)
}

//TODO:
func (r CompanyRepository) GetVacancies(id int64) ([]models.Vacancy, error) {
	return nil, nil
}