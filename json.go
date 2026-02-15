package main

import (
	"encoding/json"
	"fmt"
	"os"
)

func readJSON[T any](arr *[]*T) error {
	var el T
	var err error
	path := fmt.Sprintf("data/%T.json", el)
	file, err := os.Open(path)
	if err != nil {
		return fmt.Errorf("No such file %v: %w", path, err)
	}
	defer file.Close()
	decoder := json.NewDecoder(file)
	err = decoder.Decode(arr)
	if err != nil {
		return fmt.Errorf("JSON error: %w\n", err)
	}
	return nil
}
