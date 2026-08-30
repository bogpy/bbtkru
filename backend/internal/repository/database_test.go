package repository

import (
	"path/filepath"
	"testing"

	"github.com/jmoiron/sqlx"
	_ "modernc.org/sqlite"
)

func TestMigrateDBAddsCompanyOwnerWithoutChangingExistingRows(t *testing.T) {
	dbPath := filepath.Join(t.TempDir(), "legacy.db")
	db := sqlx.MustConnect("sqlite", "file:"+dbPath+"?_pragma=foreign_keys(1)")
	t.Cleanup(func() { _ = db.Close() })

	db.MustExec(`
		CREATE TABLE user (
			id INTEGER PRIMARY KEY,
			name TEXT NOT NULL UNIQUE,
			email TEXT NOT NULL UNIQUE,
			password TEXT NOT NULL
		);
		CREATE TABLE company (
			id INTEGER PRIMARY KEY,
			name TEXT NOT NULL UNIQUE,
			country TEXT,
			yearFound INTEGER,
			employeeCount INTEGER
		);
		INSERT INTO company (id, name, country, yearFound, employeeCount)
		VALUES (1, 'Legacy Company', 'USA', 2020, 10);
	`)

	if err := MigrateDB(db); err != nil {
		t.Fatalf("first migration: %v", err)
	}
	if err := MigrateDB(db); err != nil {
		t.Fatalf("second migration must be safe: %v", err)
	}

	var ownerColumnCount int
	if err := db.Get(
		&ownerColumnCount,
		`SELECT COUNT(*) FROM pragma_table_info('company') WHERE name = 'ownerUserID'`,
	); err != nil {
		t.Fatalf("inspect company schema: %v", err)
	}
	if ownerColumnCount != 1 {
		t.Fatalf("ownerUserID column count = %d, want 1", ownerColumnCount)
	}

	var legacyOwner *int64
	if err := db.Get(&legacyOwner, `SELECT ownerUserID FROM company WHERE id = 1`); err != nil {
		t.Fatalf("load legacy company owner: %v", err)
	}
	if legacyOwner != nil {
		t.Fatalf("legacy company owner = %v, want NULL", *legacyOwner)
	}

	var indexCount int
	if err := db.Get(
		&indexCount,
		`SELECT COUNT(*) FROM sqlite_master WHERE type = 'index' AND name = 'idx_company_owner_user_id'`,
	); err != nil {
		t.Fatalf("inspect company owner index: %v", err)
	}
	if indexCount != 1 {
		t.Fatalf("company owner index count = %d, want 1", indexCount)
	}
}
