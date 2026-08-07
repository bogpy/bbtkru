package repository

import (
	"fmt"
	"strings"

	"github.com/bogpy/bbtkru/internal/models"
	"github.com/jmoiron/sqlx"
)

type CompanyRepository struct {
	DB *sqlx.DB
}

func NewCompanyRepository(db *sqlx.DB) *CompanyRepository {
	return &CompanyRepository{DB: db}
}

func (r CompanyRepository) GetCompanyByID(id int64) (*models.Company, error) {
	var company models.Company
	err := r.DB.Get(
		&company,
		"SELECT * FROM company WHERE (id) = (?)",
		id,
	)
	if err != nil {
		return nil, err
	}
	company.Vacancies, err = r.GetVacancies(company.ID)
	if err != nil {
		return nil, err
	}
	return &company, err
}

func (r CompanyRepository) GetCompanies(request models.RequestForCompany) ([]models.Company, error) {
	var queryBuilder strings.Builder
	queryBuilder.WriteString("SELECT * FROM company WHERE 1=1")
	var args []interface{}
	if request.Name != nil && strings.TrimSpace(*request.Name) != "" {
		queryBuilder.WriteString(" AND instr(lower(name), lower(?)) > 0")
		args = append(args, strings.TrimSpace(*request.Name))
	}

	if request.EmployeeCount != nil {
		queryBuilder.WriteString(" AND employeeCount >= ?")
		args = append(args, *request.EmployeeCount)
	}

	if request.Country != nil && strings.TrimSpace(*request.Country) != "" {
		queryBuilder.WriteString(" AND instr(lower(country), lower(?)) > 0")
		args = append(args, strings.TrimSpace(*request.Country))
	}

	companies := make([]models.Company, 0)
	query := queryBuilder.String()
	err := r.DB.Select(&companies, query, args...)
	if err != nil {
		return nil, err
	}
	return companies, nil
}

func (r CompanyRepository) GetCompaniesByOwner(userID int64) ([]models.Company, error) {
	companies := make([]models.Company, 0)
	if err := r.DB.Select(
		&companies,
		"SELECT * FROM company WHERE ownerUserID = ? ORDER BY name",
		userID,
	); err != nil {
		return nil, err
	}
	return companies, nil
}

func (r CompanyRepository) IsOwnedBy(companyID, userID int64) (bool, error) {
	var count int
	if err := r.DB.Get(
		&count,
		"SELECT COUNT(*) FROM company WHERE id = ? AND ownerUserID = ?",
		companyID,
		userID,
	); err != nil {
		return false, err
	}
	return count == 1, nil
}

func (r CompanyRepository) DeleteCompany(id int64) error {
	result, err := r.DB.Exec("DELETE FROM vacancy WHERE CompanyID = ?", id)
	if err != nil {
		return err
	}

	result, err = r.DB.Exec("DELETE FROM company WHERE id = ?", id)
	if err != nil {
		return err
	}
	count, err := result.RowsAffected()
	if err != nil {
		return err
	}
	if count == 0 {
		return fmt.Errorf("Not found company with id: %v", id)
	}

	return nil
}

func (r CompanyRepository) DeleteCompanyOwnedBy(id, userID int64) error {
	tx, err := r.DB.Beginx()
	if err != nil {
		return err
	}
	defer func() { _ = tx.Rollback() }()

	if _, err := tx.Exec(
		`DELETE FROM vacancy
		 WHERE companyID IN (
			 SELECT id FROM company WHERE id = ? AND ownerUserID = ?
		 )`,
		id,
		userID,
	); err != nil {
		return err
	}

	result, err := tx.Exec(
		"DELETE FROM company WHERE id = ? AND ownerUserID = ?",
		id,
		userID,
	)
	if err != nil {
		return err
	}
	count, err := result.RowsAffected()
	if err != nil {
		return err
	}
	if count == 0 {
		return fmt.Errorf("company not found or not owned by user")
	}

	return tx.Commit()
}

func (r CompanyRepository) BulkInsert(companies []*models.Company) error {
	query := `INSERT INTO company
		(name, country, yearFound, employeeCount, ownerUserID)
		VALUES (:name, :country, :yearFound, :employeeCount, :ownerUserID)`
	return NamedExecWrapper(r.DB, query, companies)
}

func (r CompanyRepository) GetVacancies(id int64) ([]models.Vacancy, error) {
	query := `SELECT * FROM vacancy v
			  WHERE v.companyID = ?
			  `
	vacancies := make([]models.Vacancy, 0)
	err := r.DB.Select(&vacancies, query, id)
	if err != nil {
		return nil, err
	}
	return vacancies, err
}

func (r CompanyRepository) InsertCompany(c *models.Company) error {
	query := `INSERT INTO company
		(name, country, yearFound, employeeCount, ownerUserID)
		VALUES (:name, :country, :yearFound, :employeeCount, :ownerUserID)`
	res, err := r.DB.NamedExec(query, c)
	if err != nil {
		return err
	}
	id, err := res.LastInsertId()
	if err != nil {
		return fmt.Errorf("addCompany: %v", err)
	}
	c.ID = id
	return nil
}
