package models

import (
	"golang.org/x/crypto/bcrypt"
)

type UserType string

const (
	AdminUser     UserType = "Admin"
	ApplicantUser UserType = "Applicant"
	CompanyUser   UserType = "Company"
)

type User struct {
	ID       int64    `db:"id" json:"id"`
	Name     string   `db:"name" json:"name"`
	Email    string   `db:"email" json:"email"`
	Password string   `db:"password" json:"password,omitempty"`
	Type     UserType `db:"type" json:"type"`
}

func (u *User) HashPassword() error {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(u.Password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}
	u.Password = string(hashedPassword)
	return nil
}

func (u *User) CheckPassword(password string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(password))
	return err == nil
}

type LoginRequest struct {
	Email    string `json:"email" binding:"required"`
	Password string `json:"password" binding:"required"`
}
