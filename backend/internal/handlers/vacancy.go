package handlers

import (
	"net/http"
	"strconv"

	"github.com/bogpy/bbtkru/internal/repository"
	"github.com/bogpy/bbtkru/internal/models"
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
	if err := c.ShouldBindQuery(&request); err != nil{
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
	if err := c.ShouldBindJSON(&vacancies); err != nil{
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
	if err := c.ShouldBindJSON(&vacancy); err != nil{
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	r := repository.NewVacancyRepository(e.db)
	err := r.InsertVacancy(vacancy)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Vacancy not added"})
		return
	}
	c.JSON(http.StatusOK, nil)
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