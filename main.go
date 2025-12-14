package main

import (
	"fmt"
	"encoding/json"
	"os"
)

// comment

func dump(ent any) error {
	file_name := fmt.Sprintf("data/%T.json", ent)
	file, err := os.OpenFile(file_name, os.O_CREATE | os.O_WRONLY, 0644)
	if err != nil {
		return err;
	}
	defer file.Close()
	encoder := json.NewEncoder(file)
	encoder.SetIndent("", "  ")
	err = encoder.Encode(ent)
	if err != nil {
		return err
	}
	return nil
}

func dec(ent any) error {
    file_name := fmt.Sprintf("data/%T.json", ent)
    file, err := os.Open(file_name)
    if err != nil {
        return err
    }
    defer file.Close()
    decoder := json.NewDecoder(file)
    err = decoder.Decode(ent)
    if err != nil {
        return err
    }
    return nil
}


func main() {
	companies := []Company{
		{
			Name:          "Tinkoff",
			Country:       "Russia",
			YearFound:     2006,
			EmployeeCount: 25000,
		},
		{
			Name:          "Yandex",
			Country:       "Russia",
			YearFound:     1997,
			EmployeeCount: 18000,
		},
		{
			Name:          "Google",
			Country:       "USA",
			YearFound:     1998,
			EmployeeCount: 156000,
		},
	}

	interns := []Intern{
		{
			Name:       "Alice Smith",
			Age:        21,
			Experience: 1,
			University: "MIPT",
			Level:      2,
			Graduated:  false,
			Previous_companies: []string{"Local Startup"},
			Education_type:     "Full-time",
			Specialty:          "backend",
		},
		{
			Name:       "Bob Johnson",
			Age:        23,
			Experience: 3,
			University: "MSU",
			Level:      3,
			Graduated:  true,
			Previous_companies: []string{"Yandex", "Sber"},
			Education_type:     "Evening",
			Specialty:          "fullstack",
		},
		{
			Name:       "Carol Davis",
			Age:        20,
			Experience: 0,
			University: "HSE",
			Level:      1,
			Graduated:  false,
			Previous_companies: []string{},
			Education_type:     "Online",
			Specialty:          "frontend",
		},
	}

	vacancies := []Vacancy{
		{
			Title:                "Junior Backend Developer",
			Description:          "Develop microservices in Go",
			Company:              &companies[0],
			Necessary_experience: 1,
			Work_type:            1, // remote
			Salary_start:         80000,
			salary_end:           120000,
			Work_hours:           40,
		},
		{
			Title:                "Senior Frontend Engineer",
			Description:          "Lead React development team",
			Company:              &companies[1],
			Necessary_experience: 5,
			Work_type:            2, // inoffice
			Salary_start:         250000,
			salary_end:           350000,
			Work_hours:           35,
		},
		{
			Title:                "DevOps Intern",
			Description:          "Learn and assist with CI/CD pipelines",
			Company:              &companies[2],
			Necessary_experience: 0,
			Work_type:            3, // outoffice
			Salary_start:         40000,
			salary_end:           60000,
			Work_hours:           20,
		},
	}

	for i, company := range companies {
		if err := dump(company); err != nil {
			fmt.Printf("Error dumping company %d: %v\n", i, err)
		}
	}

	for i, intern := range interns {
		if err := dump(intern); err != nil {
			fmt.Printf("Error dumping intern %d: %v\n", i, err)
		}
	}

	for i, vacancy := range vacancies {
		if err := dump(vacancy); err != nil {
			fmt.Printf("Error dumping vacancy %d: %v\n", i, err)
		}
	}

	fmt.Println("Test data generated successfully!")

	var loadedCompany Company
	if err := dec(&loadedCompany); err != nil {
		fmt.Printf("Error reading company: %v\n", err)
	} else {
		fmt.Printf("Loaded company: %s\n", loadedCompany.Name)
	}

	var loadedIntern Intern
	if err := dec(&loadedIntern); err != nil {
		fmt.Printf("Error reading intern: %v\n", err)
	} else {
		fmt.Printf("Loaded intern: %s\n", loadedIntern.Name)
	}
}
