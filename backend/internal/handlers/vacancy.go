package handlers

import (
	"log"
	"net/http"
	"strconv"

	"github.com/bogpy/bbtkru/internal/models"
	"github.com/bogpy/bbtkru/internal/repository"
	"github.com/gin-gonic/gin"
)

func (e Env) GetVacancyByID(c *gin.Context) {
	id, err := strconv.ParseInt(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	r := repository.NewVacancyRepository(e.db)
	vacancy, err := r.GetVacancyByID(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Vacancy not found"})
		return
	}
	c.JSON(http.StatusOK, vacancy)
}

func (e Env) GetVacancies(c *gin.Context) {
	var request models.RequestForVacancy
	if err := c.ShouldBindQuery(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	r := repository.NewVacancyRepository(e.db)
	vacancies, err := r.GetVacancies(request)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Vacancies not found"})
		return
	}
	c.JSON(http.StatusOK, vacancies)
}

func (e Env) InsertVacancies(c *gin.Context) {
	var vacancies []*models.Vacancy
	if err := c.ShouldBindJSON(&vacancies); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	r := repository.NewVacancyRepository(e.db)
	err := r.BulkInsert(vacancies)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Vacancies not added"})
		return
	}
	c.JSON(http.StatusOK, nil)
}

func (e Env) InsertVacancy(c *gin.Context) {
	var vacancy *models.Vacancy

	if err := c.ShouldBindJSON(&vacancy); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	r := repository.NewVacancyRepository(e.db)

	if err := r.InsertVacancy(vacancy); err != nil {
		log.Printf("Error inserting vacancy: %v", err)
		c.JSON(
			http.StatusInternalServerError,
			gin.H{"error": "Vacancy not added"},
		)
		return
	}

	var languages []models.Language
	if err := e.db.Select(
		&languages,
		"SELECT id, name FROM language",
	); err != nil {
		log.Printf("Error loading languages: %v", err)
		c.JSON(
			http.StatusInternalServerError,
			gin.H{"error": "Vacancy languages not added"},
		)
		return
	}

	languageIDs := make(map[string]int64, len(languages))
	for _, language := range languages {
		languageIDs[language.Name] = language.ID
	}

	var technologies []models.Technology
	if err := e.db.Select(
		&technologies,
		"SELECT id, name FROM technology",
	); err != nil {
		log.Printf("Error loading technologies: %v", err)
		c.JSON(
			http.StatusInternalServerError,
			gin.H{"error": "Vacancy technologies not added"},
		)
		return
	}

	technologyIDs := make(map[string]int64, len(technologies))
	for _, technology := range technologies {
		technologyIDs[technology.Name] = technology.ID
	}

	if err := r.InsertJunction(
		[]*models.Vacancy{vacancy},
		languageIDs,
		technologyIDs,
	); err != nil {
		log.Printf("Error inserting vacancy skills: %v", err)
		c.JSON(
			http.StatusInternalServerError,
			gin.H{"error": "Vacancy skills not added"},
		)
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"message": "Vacancy added successfully",
		"id":      vacancy.ID,
	})
}

func (e Env) DeleteVacancyByID(c *gin.Context) {
	id, err := strconv.ParseInt(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	r := repository.NewVacancyRepository(e.db)
	err = r.DeleteVacancy(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Vacancy not deleted"})
		return
	}
	c.JSON(http.StatusOK, nil)
}
