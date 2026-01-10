package main

type Company struct {
	ID			  int
	Name          string
	Country       string
	YearFound     int //foundation year
	EmployeeCount int
	Vacancies     []*Vacancy
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
	count, err := result.RowsAffected()
	if err != nil {
		return err
	}
	
	return nil
}