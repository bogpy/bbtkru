package handlers

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"path/filepath"
	"strconv"
	"testing"
	"time"

	appauth "github.com/bogpy/bbtkru/internal/auth"
	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
	_ "modernc.org/sqlite"
)

func newSearchTestRouter(t *testing.T) *gin.Engine {
	t.Helper()
	t.Setenv("JWT_KEY", "search-test-key")

	dbPath := filepath.Join(t.TempDir(), "search.db")
	db := sqlx.MustConnect("sqlite", "file:"+dbPath+"?_pragma=foreign_keys(1)")
	t.Cleanup(func() { _ = db.Close() })

	db.MustExec(`
		CREATE TABLE user (
			id INTEGER PRIMARY KEY,
			name TEXT NOT NULL UNIQUE,
			email TEXT NOT NULL UNIQUE,
			password TEXT NOT NULL,
			type TEXT
		);
		CREATE TABLE applicant (
			id INTEGER PRIMARY KEY,
			name TEXT NOT NULL,
			dateOfBirth DATETIME,
			education TEXT,
			university TEXT,
			graduated BOOLEAN,
			specialty TEXT,
			level TEXT,
			experience INTEGER,
			workHistory TEXT
		);
		CREATE TABLE company (
			id INTEGER PRIMARY KEY,
			name TEXT NOT NULL,
			country TEXT,
			yearFound INTEGER,
			employeeCount INTEGER,
			ownerUserID INTEGER REFERENCES user(id) ON DELETE SET NULL
		);
		CREATE TABLE vacancy (
			id INTEGER PRIMARY KEY,
			title TEXT NOT NULL,
			description TEXT,
			companyID INTEGER NOT NULL,
			experience INTEGER,
			salary INTEGER,
			hours INTEGER,
			employment TEXT,
			location TEXT,
			FOREIGN KEY (companyID) REFERENCES company(id)
		);
		CREATE TABLE language (id INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE);
		CREATE TABLE technology (id INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE);
		CREATE TABLE applicant_language (
			applicant_id INTEGER,
			language_id INTEGER,
			PRIMARY KEY (applicant_id, language_id)
		);
		CREATE TABLE applicant_technology (
			applicant_id INTEGER,
			technology_id INTEGER,
			PRIMARY KEY (applicant_id, technology_id)
		);
		CREATE TABLE vacancy_language (
			vacancy_id INTEGER,
			language_id INTEGER,
			PRIMARY KEY (vacancy_id, language_id)
		);
		CREATE TABLE vacancy_technology (
			vacancy_id INTEGER,
			technology_id INTEGER,
			PRIMARY KEY (vacancy_id, technology_id)
		);
	`)
	db.MustExec(`INSERT INTO user (id, name, email, password, type) VALUES
		(1, 'Owner', 'owner@example.com', 'test-password', 'Company'),
		(2, 'Other owner', 'other@example.com', 'test-password', 'Company')`)

	birthDate := time.Date(2000, time.January, 2, 0, 0, 0, 0, time.UTC)
	db.MustExec(`INSERT INTO applicant
		(id, name, dateOfBirth, education, university, graduated, specialty, level, experience, workHistory)
		VALUES
		(1, 'Alice Developer', ?, 'Bachelor', 'Example University', 1, 'Backend', 'Junior', 2, 'Go developer'),
		(2, 'Bob Designer', ?, 'Master', 'Example University', 0, 'Frontend', 'Senior', 7, 'UI developer')`,
		birthDate, birthDate,
	)
	db.MustExec(`INSERT INTO company (id, name, country, yearFound, employeeCount, ownerUserID) VALUES
		(1, 'Acme Labs', 'USA', 2020, 25, 1),
		(2, 'Beta Studio', 'Canada', 2018, 10, 2)`)
	db.MustExec(`INSERT INTO vacancy
		(id, title, description, companyID, experience, salary, hours, employment, location)
		VALUES
		(1, 'Flutter Engineer', 'Build web applications', 1, 2, 6000, 40, 'Full-time', 'Remote'),
		(2, 'Go Intern', 'Learn backend development', 2, 0, 1500, 20, 'Internship', 'Hybrid')`)
	db.MustExec(`INSERT INTO language (id, name) VALUES (1, 'English')`)
	db.MustExec(`INSERT INTO technology (id, name) VALUES (1, 'Go')`)
	db.MustExec(`INSERT INTO applicant_language VALUES (1, 1)`)
	db.MustExec(`INSERT INTO applicant_technology VALUES (1, 1)`)
	db.MustExec(`INSERT INTO vacancy_language VALUES (1, 1)`)
	db.MustExec(`INSERT INTO vacancy_technology VALUES (1, 1)`)

	gin.SetMode(gin.TestMode)
	router := gin.New()
	env := NewEnv(db)
	router.GET("/applicants", env.GetApplicants)
	router.GET("/companies", env.GetCompanies)
	router.GET("/companies/:id", env.GetCompanyByID)
	router.GET("/companies/vacancies/:id", env.GetVacanciesByCompanyID)
	router.GET("/vacancies", env.GetVacancies)
	private := router.Group("/private", appauth.JwtMiddleware())
	private.GET("/companies", env.GetOwnedCompanies)
	private.POST("/companies", env.InsertCompany)
	private.POST("/vacancies", env.InsertVacancy)
	return router
}

func getSearchResults(t *testing.T, router http.Handler, target string) []map[string]any {
	t.Helper()

	request := httptest.NewRequest(http.MethodGet, target, nil)
	response := httptest.NewRecorder()
	router.ServeHTTP(response, request)
	if response.Code != http.StatusOK {
		t.Fatalf("GET %s returned %d: %s", target, response.Code, response.Body.String())
	}

	var results []map[string]any
	if err := json.Unmarshal(response.Body.Bytes(), &results); err != nil {
		t.Fatalf("decode GET %s response: %v", target, err)
	}
	return results
}

func TestApplicantSearchAndFilters(t *testing.T) {
	router := newSearchTestRouter(t)

	results := getSearchResults(t, router,
		"/applicants?name=alice&experience=2&level=Junior&graduated=true&education=Bachelor&specialty=Backend&languagesRequired=English&technologiesRequired=Go",
	)
	if len(results) != 1 || results[0]["name"] != "Alice Developer" {
		t.Fatalf("expected Alice Developer, got %#v", results)
	}

	results = getSearchResults(t, router, "/applicants?name=missing")
	if len(results) != 0 {
		t.Fatalf("expected no applicants, got %#v", results)
	}
}

func TestCompanySearchAndFilters(t *testing.T) {
	router := newSearchTestRouter(t)

	results := getSearchResults(t, router, "/companies?name=ACME&country=us&employeeCount=20")
	if len(results) != 1 || results[0]["name"] != "Acme Labs" {
		t.Fatalf("expected Acme Labs, got %#v", results)
	}

	results = getSearchResults(t, router, "/companies?name=missing")
	if len(results) != 0 {
		t.Fatalf("expected no companies, got %#v", results)
	}
}

func TestCreateAndOpenCompanyWithoutVacancies(t *testing.T) {
	router := newSearchTestRouter(t)
	token, err := appauth.GenerateJWT("owner@example.com")
	if err != nil {
		t.Fatalf("generate owner token: %v", err)
	}

	created := performJSONRequest(t, router, http.MethodPost, "/private/companies",
		`{"name":"New Company","country":"USA","yearFound":2026,"employeeCount":0}`,
		token,
	)
	if created.Code != http.StatusCreated {
		t.Fatalf("create company returned %d: %s", created.Code, created.Body.String())
	}

	var company map[string]any
	if err := json.Unmarshal(created.Body.Bytes(), &company); err != nil {
		t.Fatalf("decode created company: %v", err)
	}
	companyID, ok := company["id"].(float64)
	if !ok || companyID == 0 {
		t.Fatalf("created company has invalid id: %#v", company)
	}

	detailRequest := httptest.NewRequest(http.MethodGet, "/companies/"+strconv.Itoa(int(companyID)), nil)
	detailResponse := httptest.NewRecorder()
	router.ServeHTTP(detailResponse, detailRequest)
	if detailResponse.Code != http.StatusOK {
		t.Fatalf("get company returned %d: %s", detailResponse.Code, detailResponse.Body.String())
	}
	if err := json.Unmarshal(detailResponse.Body.Bytes(), &company); err != nil {
		t.Fatalf("decode company detail: %v", err)
	}
	vacancies, ok := company["vacancies"].([]any)
	if !ok || len(vacancies) != 0 {
		t.Fatalf("company vacancies must be an empty array, got %#v", company["vacancies"])
	}

	results := getSearchResults(t, router, "/companies/vacancies/"+strconv.Itoa(int(companyID)))
	if len(results) != 0 {
		t.Fatalf("expected no company vacancies, got %#v", results)
	}
}

func TestVacancyCanOnlyBePostedForOwnedCompany(t *testing.T) {
	router := newSearchTestRouter(t)
	ownerToken, err := appauth.GenerateJWT("owner@example.com")
	if err != nil {
		t.Fatalf("generate owner token: %v", err)
	}
	otherToken, err := appauth.GenerateJWT("other@example.com")
	if err != nil {
		t.Fatalf("generate other owner token: %v", err)
	}

	ownedCompanies := performJSONRequest(
		t,
		router,
		http.MethodGet,
		"/private/companies",
		"",
		ownerToken,
	)
	if ownedCompanies.Code != http.StatusOK {
		t.Fatalf("get owned companies returned %d: %s", ownedCompanies.Code, ownedCompanies.Body.String())
	}
	var companies []map[string]any
	if err := json.Unmarshal(ownedCompanies.Body.Bytes(), &companies); err != nil {
		t.Fatalf("decode owned companies: %v", err)
	}
	if len(companies) != 1 || companies[0]["name"] != "Acme Labs" {
		t.Fatalf("expected only Acme Labs, got %#v", companies)
	}

	body := `{
		"title":"Owned vacancy",
		"description":"Can only belong to the signed-in owner's company",
		"companyID":1,
		"experience":1,
		"salary":1000,
		"hours":20,
		"employment":"Internship",
		"location":"Remote",
		"languages":["English"],
		"technologies":["Go"]
	}`
	created := performJSONRequest(t, router, http.MethodPost, "/private/vacancies", body, ownerToken)
	if created.Code != http.StatusCreated {
		t.Fatalf("create owned vacancy returned %d: %s", created.Code, created.Body.String())
	}

	forbidden := performJSONRequest(t, router, http.MethodPost, "/private/vacancies", body, otherToken)
	if forbidden.Code != http.StatusForbidden {
		t.Fatalf("create vacancy for another owner's company returned %d, want 403: %s", forbidden.Code, forbidden.Body.String())
	}
}

func TestVacancySearchAndFilters(t *testing.T) {
	router := newSearchTestRouter(t)

	results := getSearchResults(t, router,
		"/vacancies?title=flutter&experience=3&salary=5000&employment=Full-time&location=Remote&country=usa&hours=40&languages=English&technologies=Go",
	)
	if len(results) != 1 || results[0]["title"] != "Flutter Engineer" {
		t.Fatalf("expected Flutter Engineer, got %#v", results)
	}

	results = getSearchResults(t, router, "/vacancies?title=missing")
	if len(results) != 0 {
		t.Fatalf("expected no vacancies, got %#v", results)
	}
}

func TestFilterEnumsRejectNonCanonicalValues(t *testing.T) {
	router := newSearchTestRouter(t)

	for _, target := range []string{
		"/applicants?level=junior",
		"/vacancies?employment=fullTime",
	} {
		request := httptest.NewRequest(http.MethodGet, target, nil)
		response := httptest.NewRecorder()
		router.ServeHTTP(response, request)
		if response.Code != http.StatusBadRequest {
			t.Fatalf("GET %s returned %d, want 400", target, response.Code)
		}
	}
}
