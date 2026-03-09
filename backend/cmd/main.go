package main

import (
	"log"
	"os"

	"github.com/jmoiron/sqlx"
	"github.com/joho/godotenv"

	"github.com/bogpy/bbtkru/internal/handlers"
	"github.com/bogpy/bbtkru/internal/repository"
	"github.com/gin-gonic/gin"
)

func main() {
	file, err := os.OpenFile("log.txt", os.O_CREATE | os.O_WRONLY | os.O_TRUNC, 0666)
	if err != nil {
		log.Fatal("Failed to open log file")
	}
	log.SetOutput(file)
	err = godotenv.Load()
	if err != nil {
		log.Fatal(err)
	}

	var db *sqlx.DB
	db = repository.ConnectDB()
	defer db.Close()
	repository.InitDB(db)
	repository.PopulateDB(db)

	env := handlers.NewEnv(db)

	router := gin.Default()
	
	router.GET("/applicants/:id", env.GetApplicantByID)
	router.GET("/applicants", env.GetApplicants)
	router.GET("/companies", env.GetCompanies)
	router.GET("/companies/:id", env.GetCompanyByID)
	router.GET("/vacancies", env.GetVacancies)
	router.GET("/vacancies/:id", env.GetVacancyByID)

	router.POST("/vacancies", env.InsertVacancy)
	router.POST("/applicants", env.InsertApplicant)
	router.POST("/companies", env.InsertCompany)
	
	router.DELETE("/companies/:id", env.DeleteCompanyByID)
	router.DELETE("/vacancies/:id", env.DeleteVacancyByID)
	router.DELETE("/applicants/:id", env.DeleteApplicantByID)

	router.Run()
}
