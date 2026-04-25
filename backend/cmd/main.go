package main

import (
	"log"
	"os"
	"time"

	"github.com/jmoiron/sqlx"
	"github.com/joho/godotenv"

	"github.com/bogpy/bbtkru/internal/handlers"
	"github.com/bogpy/bbtkru/internal/repository"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	file, err := os.OpenFile("log.txt", os.O_CREATE|os.O_WRONLY|os.O_TRUNC, 0666)
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
	if os.Getenv("APP_ENV") != "production" && len(os.Args) > 1 && os.Args[1] == "dropdb" {
		repository.InitDB(db)
		repository.PopulateDB(db)
		return
	}
	env := handlers.NewEnv(db)

	router := gin.Default()
	router.Use(func(c *gin.Context) {
		log.Printf("Inbound Request - IP: %s | Origin: %s\n", c.ClientIP(), c.GetHeader("Origin"))
		c.Next()
	})
	router.SetTrustedProxies([]string{"127.0.0.1"})
	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"http://localhost:5001"},
		AllowMethods:     []string{"GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}))

	router.GET("/applicants/:id", env.GetApplicantByID)
	router.GET("/applicants", env.GetApplicants)
	router.GET("/companies", env.GetCompanies)
	router.GET("/companies/:id", env.GetCompanyByID)
	router.GET("/companies/vacancies:id", env.GetVacanciesByCompanyID)
	router.GET("/vacancies", env.GetVacancies)
	router.GET("/vacancies/:id", env.GetVacancyByID)
	router.GET("/languages", env.GetAllLanguages)
	router.GET("/technologies", env.GetAllTechnologies)

	router.POST("/vacancies", env.InsertVacancy)
	router.POST("/applicants", env.InsertApplicant)
	router.POST("/companies", env.InsertCompany)

	router.DELETE("/companies/:id", env.DeleteCompanyByID)
	router.DELETE("/vacancies/:id", env.DeleteVacancyByID)
	router.DELETE("/applicants/:id", env.DeleteApplicantByID)

	router.Run(":8080")
}
