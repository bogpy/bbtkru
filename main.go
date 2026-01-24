package main

type Language struct {
	ID   int64 `db:"ID"`
	Name string	`db:"Name"`
}

type Technology struct {
	ID   int64 `db:"ID"`
	Name string	`db:"Name"`
}

func main() {
	db := connectToDB()
	defer db.Close()
	populateDB(db)
}
