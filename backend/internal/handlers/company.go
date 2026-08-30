package handlers

import (
	"net/http"
	"strconv"

	"github.com/bogpy/bbtkru/internal/models"
	"github.com/bogpy/bbtkru/internal/repository"
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
	if err := c.ShouldBindQuery(&request); err != nil {
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

func (e Env) GetOwnedCompanies(c *gin.Context) {
	userID, ok := e.authenticatedUserID(c)
	if !ok {
		return
	}

	r := repository.NewCompanyRepository(e.db)
	companies, err := r.GetCompaniesByOwner(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Companies not found"})
		return
	}
	c.JSON(http.StatusOK, companies)
}

func (e Env) GetVacanciesByCompanyID(c *gin.Context) {
	id, err := strconv.ParseInt(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	r := repository.NewCompanyRepository(e.db)
	company, err := r.GetVacancies(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Company not found"})
		return
	}
	c.JSON(http.StatusOK, company)
}

func (e Env) InsertCompanies(c *gin.Context) {
	var companies []*models.Company
	if err := c.ShouldBindJSON(&companies); err != nil {
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
	userID, ok := e.authenticatedUserID(c)
	if !ok {
		return
	}

	var company *models.Company
	if err := c.ShouldBindJSON(&company); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	company.OwnerUserID = &userID
	r := repository.NewCompanyRepository(e.db)
	err := r.InsertCompany(company)
	if err != nil {
		c.JSON(http.StatusConflict, gin.H{"error": "Company not added"})
		return
	}
	c.JSON(http.StatusCreated, company)
}

func (e Env) DeleteCompanyByID(c *gin.Context) {
	userID, ok := e.authenticatedUserID(c)
	if !ok {
		return
	}

	id, err := strconv.ParseInt(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	r := repository.NewCompanyRepository(e.db)
	err = r.DeleteCompanyOwnedBy(id, userID)
	if err != nil {
		c.JSON(http.StatusForbidden, gin.H{"error": "Company not found or not owned by user"})
		return
	}
	c.JSON(http.StatusOK, nil)
}
