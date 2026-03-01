package handlers

import (
	"net/http"
	"strconv"

	"github.com/bogpy/bbtkru/internal/repository"
	"github.com/bogpy/bbtkru/internal/models"
	"github.com/gin-gonic/gin"
)

func (e Env) GetApplicantByID(c *gin.Context) {
	id, err := strconv.ParseInt(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	r := repository.NewApplicantRepository(e.db)
	applicant, err := r.GetApplicantByID(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Applicant not found"})
		return
	}
	c.JSON(http.StatusOK, applicant)
}

func (e Env) GetApplicants(c *gin.Context) {
	var request models.RequestForApplicant
	if err := c.ShouldBindJSON(&request); err != nil{
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	r := repository.NewApplicantRepository(e.db)
	applicants, err := r.GetApplicants(request)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Applicants not found"})
		return
	}
	c.JSON(http.StatusOK, applicants)
}

func (e Env) InsertApplicants(c *gin.Context) {
	var applicants []*models.Applicant
	if err := c.ShouldBindJSON(&applicants); err != nil{
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	r := repository.NewApplicantRepository(e.db)
	err := r.BulkInsert(applicants)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Applicants not added"})
		return
	}
	c.JSON(http.StatusOK, nil)
}