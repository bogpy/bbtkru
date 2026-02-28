package main

import (
	"log"

	"github.com/jmoiron/sqlx"
	"github.com/joho/godotenv"

	"github.com/bogpy/bbtkru/internal/repository"
	"github.com/gin-gonic/gin"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal(err)
	}

	var db *sqlx.DB
	db = repository.ConnectDB()
	defer db.Close()
	repository.InitDB(db)
	repository.PopulateDB(db)

	router := gin.Default()
	
	router.GET("/applicants/:id", getApplicantByID)

	// router.GET("/applicants", getApplicants)
	// router.POST("/vacancies", insertVacancy)
	// router.DELETE("/vacancies/:id", deleteVacancyByID)

	router.Run()
}
