package Utils

import (
	"log"
	"os"
	"path/filepath"
	"runtime"
	"strconv"
	"strings"
)

// CheckGoVersio function
func CheckGoVersion() {
	version := runtime.Version()
	version = strings.Replace(version, "go1.", "", -1)
	verNumb, _ := strconv.ParseFloat(version, 64)
	if verNumb < 19.1 {
		logger := log.New(os.Stderr, "[!] ", 0)
		logger.Fatal("The version of Go is to old, please update to version 1.19.1 or later...\n")
	}
}

// GetAbsolutePath function
func GetAbsolutePath(file string) string {
	logger := log.New(os.Stderr, "[!] ", 0)
	absolutePath, err := filepath.Abs(file)
	if err != nil {
		logger.Fatal("Error:", err)
		return ""
	}

	return absolutePath
}
