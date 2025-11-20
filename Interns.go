package main

type Intern struct {
	Name               string
	Age                int
	Experience         int
	University         string
	Level              int8
	Graduated          bool
	Previous_companies []string
	Education_type     string
	Specialty          string // backend frontend fullsteck
}

// func NewIntern(_name string, _age string, _exp int, _univ int, _level int8, _prev_comp []string) *Intern{
// 	return &Intern{
// 		name: _name,
// 		age: _age,
// 		experience: _exp,
// 		university: _univ,
// 		level: _level,
// 		previous_companies: _prev_comp,
// 	}
// }