package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
)

func readJSON[T any](arr *[]T) {
	var el T
	path := fmt.Sprintf("data/%T.json", el)
	file, err := os.Open(path)
	if err != nil {
		fmt.Printf("No such file: %v\n", path)
		return
	}
	defer file.Close()
	decoder := json.NewDecoder(file)
	err = decoder.Decode(arr)
	if err != nil {
		fmt.Printf("JSON error: %v\n", err)
		var typeErr *json.UnmarshalTypeError
		if errors.As(err, &typeErr) {
			fmt.Printf("❌ Type Mismatch!\n")
			fmt.Printf("Key: %s\n", typeErr.Field)
			fmt.Printf("Provided Value: %s\n", typeErr.Value) // This is the "bad" string
			fmt.Printf("Expected Type: %v\n", typeErr.Type)
			fmt.Printf("Location in JSON: byte %d\n", typeErr.Offset)
		}
	}
}
