package handlers

import (
	"net/http"
	

	"github.com/bogpy/bbtkru/internal/repository"
	"github.com/gin-gonic/gin"
)

func (e Env) GetAllLanguages(c *gin.Context) {
	r := repository.NewLanguageRepository(e.db)
	languages, err := r.GetAll()
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Languages not found"})
		return
	}
	c.JSON(http.StatusOK, languages)
}