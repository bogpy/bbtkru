package handlers

import (
	"net/http"
	"strconv"

	"github.com/bogpy/bbtkru/internal/repository"
	"github.com/bogpy/bbtkru/internal/models"
	"github.com/gin-gonic/gin"
)

func (e Env) GetCompanyByID(c *gin.Context) {
	id, err := strconv.ParseInt(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	r := repository.NewCompanyRepository(e.db)
	company, err := r.GetCompanyByID(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Company not found"})
		return
	}
	c.JSON(http.StatusOK, company)
}

func (e Env) GetCompanies(c *gin.Context) {
	var request models.RequestForCompany
	if err := c.ShouldBindJSON(&request); err != nil{
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	r := repository.NewCompanyRepository(e.db)
	companies, err := r.GetCompanies(request)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Companies not found"})
		return
	}
	c.JSON(http.StatusOK, companies)
}

func (e Env) InsertCompanies(c *gin.Context) {
	var companies []*models.Company
	if err := c.ShouldBindJSON(&companies); err != nil{
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	r := repository.NewCompanyRepository(e.db)
	err := r.BulkInsert(companies)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Companies not added"})
		return
	}
	c.JSON(http.StatusOK, nil)
}

func (e Env) InsertCompany(c *gin.Context) {
	var company *models.Company
	if err := c.ShouldBindJSON(&company); err != nil{
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	r := repository.NewCompanyRepository(e.db)
	err := r.InsertCompany(company)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Company not added"})
		return
	}
	c.JSON(http.StatusOK, nil)
}

func (e Env) DeleteCompanyByID(c *gin.Context) { 
	id, err := strconv.ParseInt(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	r := repository.NewCompanyRepository(e.db)
	err = r.DeleteCompany(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Company not deleted"})
		return
	}
	c.JSON(http.StatusOK, nil)
}