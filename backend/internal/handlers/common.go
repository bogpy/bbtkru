package handlers

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
)

type Env struct {
	db *sqlx.DB
}

func NewEnv(db *sqlx.DB) *Env {
	return &Env{db: db}
}

func (e Env) authenticatedUserID(c *gin.Context) (int64, bool) {
	emailValue, exists := c.Get("username")
	email, ok := emailValue.(string)
	if !exists || !ok || email == "" {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "User identity missing"})
		return 0, false
	}

	var userID int64
	if err := e.db.Get(&userID, "SELECT id FROM user WHERE email = ?", email); err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "User not found"})
		return 0, false
	}

	return userID, true
}
