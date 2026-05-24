package handlers

import (
	"github.com/bogpy/bbtkru/internal/auth"
	"github.com/bogpy/bbtkru/internal/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

func (e Env) LoginHandler(c *gin.Context) {
	var loginReq models.LoginRequest
	if err := c.ShouldBindJSON(&loginReq); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	var user models.User
	err := e.db.Get(&user,
		"SELECT id, username, password FROM user WHERE name = ?",
		loginReq.Username,
	)
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
		c.JSON(
			http.StatusInternalServerError,
			gin.H{"error": "Failed to generate token"},
		)
		return
	}

	c.JSON(http.StatusOK, gin.H{"token": token})
}

func (e Env) RegisterHandler(c *gin.Context) {
	var user models.User
	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(
			http.StatusBadRequest,
			gin.H{"error": "Invalid request body"},
		)
		return
	}

	if err := user.HashPassword(); err != nil {
		c.JSON(
			http.StatusInternalServerError,
			gin.H{"error": "Failed to process password"},
		)
		return
	}

	query := `INSERT INTO user (name, password) VALUES (?, ?)`
	_, err := e.db.Exec(query, user.Username, user.Password)
	if err != nil {
		c.JSON(
			http.StatusConflict,
			gin.H{"error": "User already exists or database error"},
		)
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "User registered successfully"})
}

func (e Env) LogoutHandler(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{"message": "Successfully logged out"})
}
