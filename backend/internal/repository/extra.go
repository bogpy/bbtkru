package repository

import (
	"github.com/bogpy/bbtkru/internal/models"
	"github.com/jmoiron/sqlx"
	_ "modernc.org/sqlite"
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

func (r LanguageRepository) GetAll() ([]models.Language, error) {
	query := `SELECT * FROM language`

	var languages []models.Language
	err := r.DB.Select(&languages, query)
	if err != nil {
		return nil, err
	}
	return languages, nil
}

func (r TechnologyRepository) GetAll() ([]models.Technology, error) {
	query := `SELECT * FROM technology`

	var technolgies []models.Technology
	err := r.DB.Select(&technolgies, query)
	if err != nil {
		return nil, err
	}
	return technolgies, nil
}
