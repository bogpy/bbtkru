package repository

import (
	"github.com/bogpy/bbtkru/internal/models"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

type IdSetter interface {
	SetID(int64)
}

type IdGetter interface {
	GetID() int64
}

type LanguageGetter interface {
	GetLanguages() []models.Language
}

type TechnologyGetter interface {
	GetTechnologies() []models.Technology
}

type LanguageRepository struct {
	DB *sqlx.DB
}

type TechnologyRepository struct {
	DB *sqlx.DB
}

func NewLanguageRepository(db *sqlx.DB) *LanguageRepository {
	return &LanguageRepository{DB: db}
}

func NewTechnologyRepository(db *sqlx.DB) *TechnologyRepository {
	return &TechnologyRepository{DB: db}
}

func (r LanguageRepository) BulkInsert(languages []*models.Language) error {
	query := `INSERT INTO language (name) VALUES (:name)`
	return NamedExecWrapper(r.DB, query, languages)
}

func (r TechnologyRepository) BulkInsert(technologies []*models.Technology) error {
	query := `INSERT INTO technology (name) VALUES (:name)`
	return NamedExecWrapper(r.DB, query, technologies)
}