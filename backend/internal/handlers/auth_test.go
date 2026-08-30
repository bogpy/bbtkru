package handlers

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"path/filepath"
	"strings"
	"testing"

	"github.com/bogpy/bbtkru/internal/auth"
	"github.com/bogpy/bbtkru/internal/models"
	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
	_ "modernc.org/sqlite"
)

func newAuthTestRouter(t *testing.T) (*gin.Engine, *sqlx.DB) {
	t.Helper()
	t.Setenv("JWT_KEY", "registration-test-key")

	dbPath := filepath.Join(t.TempDir(), "auth.db")
	db := sqlx.MustConnect("sqlite", "file:"+dbPath)
	t.Cleanup(func() { _ = db.Close() })
	db.MustExec(`CREATE TABLE user (
		id INTEGER PRIMARY KEY,
		name VARCHAR(100) NOT NULL UNIQUE,
		email VARCHAR(100) NOT NULL UNIQUE,
		password VARCHAR(255) NOT NULL,
		type TEXT
	)`)

	gin.SetMode(gin.TestMode)
	router := gin.New()
	env := NewEnv(db)
	router.POST("/auth/register", env.RegisterHandler)
	router.POST("/auth/login", env.LoginHandler)
	router.GET("/auth/me", auth.JwtMiddleware(), env.MeHandler)
	return router, db
}

func performJSONRequest(
	t *testing.T,
	router http.Handler,
	method string,
	target string,
	body string,
	token string,
) *httptest.ResponseRecorder {
	t.Helper()

	request := httptest.NewRequest(method, target, strings.NewReader(body))
	request.Header.Set("Content-Type", "application/json")
	if token != "" {
		request.Header.Set("Authorization", "Bearer "+token)
	}
	response := httptest.NewRecorder()
	router.ServeHTTP(response, request)
	return response
}

func TestRegisterReturnsUserAndToken(t *testing.T) {
	router, db := newAuthTestRouter(t)

	response := performJSONRequest(t, router, http.MethodPost, "/auth/register",
		`{"name":"  Alice Example  ","email":"ALICE@example.com","password":"secret123"}`,
		"",
	)
	if response.Code != http.StatusCreated {
		t.Fatalf("register returned %d: %s", response.Code, response.Body.String())
	}

	var registration struct {
		Token string      `json:"token"`
		User  models.User `json:"user"`
	}
	if err := json.Unmarshal(response.Body.Bytes(), &registration); err != nil {
		t.Fatalf("decode registration response: %v", err)
	}
	if registration.Token == "" {
		t.Fatal("registration response does not contain a token")
	}
	if registration.User.ID == 0 || registration.User.Name != "Alice Example" || registration.User.Email != "alice@example.com" {
		t.Fatalf("unexpected registered user: %#v", registration.User)
	}
	if registration.User.Password != "" {
		t.Fatal("registration response exposes the password")
	}

	var storedPassword string
	if err := db.Get(&storedPassword, "SELECT password FROM user WHERE id = ?", registration.User.ID); err != nil {
		t.Fatalf("load stored password: %v", err)
	}
	if storedPassword == "secret123" || !strings.HasPrefix(storedPassword, "$2") {
		t.Fatal("password was not stored as a bcrypt hash")
	}

	meResponse := performJSONRequest(t, router, http.MethodGet, "/auth/me", "", registration.Token)
	if meResponse.Code != http.StatusOK {
		t.Fatalf("auth/me returned %d: %s", meResponse.Code, meResponse.Body.String())
	}
	var me struct {
		User models.User `json:"user"`
	}
	if err := json.Unmarshal(meResponse.Body.Bytes(), &me); err != nil {
		t.Fatalf("decode auth/me response: %v", err)
	}
	if me.User.ID != registration.User.ID || me.User.Email != registration.User.Email {
		t.Fatalf("auth/me returned %#v, want %#v", me.User, registration.User)
	}

	loginResponse := performJSONRequest(t, router, http.MethodPost, "/auth/login",
		`{"email":"ALICE@EXAMPLE.COM","password":"secret123"}`,
		"",
	)
	if loginResponse.Code != http.StatusOK {
		t.Fatalf("login returned %d: %s", loginResponse.Code, loginResponse.Body.String())
	}
}

func TestRegisterRejectsInvalidAndDuplicateUsers(t *testing.T) {
	router, db := newAuthTestRouter(t)

	for _, body := range []string{
		`{}`,
		`{"name":"Alice","email":"not-an-email","password":"secret123"}`,
		`{"name":"Alice","email":"alice@example.com","password":"short"}`,
	} {
		response := performJSONRequest(t, router, http.MethodPost, "/auth/register", body, "")
		if response.Code != http.StatusBadRequest {
			t.Fatalf("register %s returned %d, want 400", body, response.Code)
		}
	}

	validBody := `{"name":"Alice","email":"alice@example.com","password":"secret123"}`
	first := performJSONRequest(t, router, http.MethodPost, "/auth/register", validBody, "")
	if first.Code != http.StatusCreated {
		t.Fatalf("first registration returned %d: %s", first.Code, first.Body.String())
	}
	duplicate := performJSONRequest(t, router, http.MethodPost, "/auth/register", validBody, "")
	if duplicate.Code != http.StatusConflict {
		t.Fatalf("duplicate registration returned %d, want 409", duplicate.Code)
	}

	var count int
	if err := db.Get(&count, "SELECT COUNT(*) FROM user"); err != nil {
		t.Fatalf("count users: %v", err)
	}
	if count != 1 {
		t.Fatalf("stored %d users, want 1", count)
	}
}
