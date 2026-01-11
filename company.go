package main

type Company struct {
	ID			  int
	Name          string
	Country       string
	YearFound     int //foundation year
	EmployeeCount int
	Vacancies     []*Vacancy
	RevenuePerYear int

}

type RequestForCompany struct {
	RevenuePerYear int
    EmployeeCount int
}

func getCompanies(db *sql.DB, request RequestForCompany) ([]Company, err) {
	var queryBuilder strings.Builder
	queryBuilder.writeString("SELECT * FROM company WHERE 1=1")
	var args []interface{}

	if request.EmployeeCount != nil {
		queryBuilder.writeString("AND EmployeeCount >= ?")
		args = append(args, request.EmployeeCount)
	}

	if request.RevenuePerYear != nil {
		queryBuilder.writeString("AND RevenuePerYear >= ?")
		args = append(args, request.RevenuePerYear)
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
		if err := rows.Scan(&c.Name, &c.Country, &c.YearFound, &c.EmployeeCount, &c.Vacancies); err != nil{
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
	count, err := result.RowsAffected()
	if err != nil {
		return err
	}
	
	return nil
}