package handlers

import (
	"net/http"


	"github.com/bogpy/bbtkru/internal/repository"
	
	"github.com/gin-gonic/gin"
)

func (e Env) GetAllTechnologies(c *gin.Context) {
	r := repository.NewTechnologyRepository(e.db)
	technolgies, err := r.GetAll()
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Technologies not found"})
		return
	}
	c.JSON(http.StatusOK, technolgies)
}