package handlers

import (
	"log"
	"net/http"

	"github.com/bogpy/bbtkru/internal/auth"
	"github.com/bogpy/bbtkru/internal/models"
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
		"SELECT * FROM user WHERE email = ?",
		loginReq.Email,
	)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid email"})
		return
	}

	if !user.CheckPassword(loginReq.Password) {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid password"})
		return
	}

	token, err := auth.GenerateJWT(user.Email)
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

	query := `INSERT INTO user (name, email, password) VALUES (?, ?, ?)`
	_, err := e.db.Exec(query, user.Name, user.Email, user.Password)
	if err != nil {
		c.JSON(
			http.StatusConflict,
			gin.H{"error": "User already exists or database error"},
		)
		log.Printf("Error: %v\n", err)
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "User registered successfully"})
}

func (e Env) LogoutHandler(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{"message": "Successfully logged out"})
}
