package models

import (
	"encoding/json"
	"fmt"
	"log"
	"strings"
)

type Language struct {
	ID   int64  `db:"id" json:"id"`
	Name string `db:"name" json:"name"`
}

type LanguageList []Language

func (x *Language) SetID(id int64) {
	x.ID = id
}

func (x *Language) UnmarshalJSON(data []byte) error {
	var name string
	if err := json.Unmarshal(data, &name); err != nil {
		return fmt.Errorf("Invalid language name %v: %w", data, err)
	}
	if name == "" || len(name) > 20 {
		return fmt.Errorf("Invalid language name %v", data)
	}
	x.Name = name
	return nil
}

func (x *Language) MarshalJSON() ([]byte, error) {
	var ans []byte
	var err error
	if ans, err = json.Marshal(x.Name); err != nil {
		return nil, fmt.Errorf("Invalid language name %v: %w", x.Name, err)
	}
	return ans, nil
}

func (x *LanguageList) UnmarshalText(text []byte) error {
	log.Printf("unmarshalling text: %v\n", string(text))
	if len(text) == 0 {
		*x = nil
		return nil
	}
	for item := range strings.SplitSeq(string(text), ",") {
		if len(item) != 0 {
			*x = append(*x, Language{Name: item})
		}
	}
	return nil
}

type Technology struct {
	ID   int64  `db:"id" json:"id"`
	Name string `db:"name" json:"name"`
}

type TechnologyList struct {
	Items []Technology
}

func (x *Technology) SetID(id int64) {
	x.ID = id
}

func (x *Technology) UnmarshalJSON(data []byte) error {
	var name string
	if err := json.Unmarshal(data, &name); err != nil {
		return fmt.Errorf("Invalid technology name %v: %w", data, err)
	}
	if name == "" || len(name) > 50 {
		return fmt.Errorf("Invalid technology name %v", data)
	}
	x.Name = name
	return nil
}

func (x *Technology) MarshalJSON() ([]byte, error) {
	var ans []byte
	var err error
	if ans, err = json.Marshal(x.Name); err != nil {
		return nil, fmt.Errorf("Invalid technology name %v: %w", x.Name, err)
	}
	return ans, nil
}

func (x *TechnologyList) UnmarshalText(text []byte) error {
	log.Printf("unmarshalling text: %v\n", string(text))
	if len(text) == 0 {
		x.Items = nil
		return nil
	}
	for item := range strings.SplitSeq(string(text), ",") {
		if len(item) != 0 {
			x.Items = append(x.Items, Technology{Name: item})
		}
	}
	return nil
}
