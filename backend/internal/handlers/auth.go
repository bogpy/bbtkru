package handlers

import (
	"net/http"
	"github.com/bogpy/bbtkru/internal/models"
	"github.com/bogpy/bbtkru/internal/auth"
	"github.com/gin-gonic/gin"
)

func (e Env) LoginHandler(c *gin.Context) {
	var loginReq models.LoginRequest
	if err := c.ShouldBindJSON(&loginReq); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}
	
	var user models.User
	err := e.db.Get(&user,
		"SELECT id, username, password FROM users WHERE username = ?",
		loginReq.Username)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid username or password"})
		return
	}

	if !user.CheckPassword(loginReq.Password) {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid username or password"})
		return
	}

	token, err := auth.GenerateJWT(user.Username)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"token": token})
}

func (e Env) LogoutHandler(c *gin.Context) {
    
}