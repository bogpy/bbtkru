package repository

import (
	"encoding/json"
	"fmt"
	"io/fs"
	"strings"
)

func ReadJSON[T any](fsys fs.FS) ([]T, error) {
	fullType := fmt.Sprintf("%T", *new(T))
	parts := strings.Split(fullType, ".")
	typeName := strings.ToLower(parts[len(parts)-1])
	fileName := typeName + ".json"
	file, err := fsys.Open(fileName)
	if err != nil {
		return nil, fmt.Errorf("No such file %v: %w", fileName, err)
	}
	defer file.Close()
	decoder := json.NewDecoder(file)
	var arr []T
	if err := decoder.Decode(&arr); err != nil {
		return nil, fmt.Errorf("JSON error: %w\n", err)
	}
	return arr, nil
}

// TODO: implement this function
func DumpJSON[T any](fys fs.FS, arr []T) error {
	return nil
}
