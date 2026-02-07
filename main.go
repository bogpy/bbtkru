package main

type ID_setter interface {
	set_ID(int64)
}

type Language struct {
	ID   int64 `db:"ID"`
	Name string	`db:"Name"`
}

func (x *Language) set_ID(id int64) {
	x.ID = id
}

type Technology struct {
	ID   int64 `db:"ID"`
	Name string	`db:"Name"`
}

func (x *Technology) set_ID(id int64) {
	x.ID = id
}

func main() {
	db := connectToDB()
	defer db.Close()
	populateDB(db)
}
