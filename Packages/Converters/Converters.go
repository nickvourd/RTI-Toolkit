package Converters

import (
	"Templator/Packages/Colors"
	"Templator/Packages/Utils"
	"archive/zip"
	"fmt"
	"io"
	"os"
	"path/filepath"
)

// CreateBackup function
func CreateBackup(originalFilename string) error {
	// Open the original file
	originalFile, err := os.Open(originalFilename)
	if err != nil {
		return err
	}
	defer originalFile.Close()

	// Create a new .bak file
	backupFilename := originalFilename + ".bak"
	backupFile, err := os.Create(backupFilename)
	if err != nil {
		return err
	}
	defer backupFile.Close()

	// Copy the content from the original file to the backup file
	_, err = io.Copy(backupFile, originalFile)
	if err != nil {
		return err
	}

	// Call function named GetAbsolutePath
	backupFullPath := Utils.GetAbsolutePath(backupFilename)

	fmt.Printf("[+] Created a backup of your original MS Office document: %s\n\n", Colors.BoldCyan(backupFullPath))
	return nil
}

// Unzip function
// Unzip extracts the contents of a zip file to a folder
func Unzip(zipFile, destFolder string) error {
	r, err := zip.OpenReader(zipFile)
	if err != nil {
		return err
	}
	defer r.Close()

	for _, f := range r.File {
		rc, err := f.Open()
		if err != nil {
			return err
		}
		defer rc.Close()

		path := filepath.Join(destFolder, f.Name)
		if f.FileInfo().IsDir() {
			os.MkdirAll(path, f.Mode())
		} else {
			os.MkdirAll(filepath.Dir(path), f.Mode())
			outFile, err := os.Create(path)
			if err != nil {
				return err
			}
			defer outFile.Close()

			_, err = io.Copy(outFile, rc)
			if err != nil {
				return err
			}
		}
	}

	return nil
}

// RemoveExtension function
// RemoveExtension removes the file extension from a given path
func RemoveExtension(path string) string {
	return filepath.Base(path[:len(path)-len(filepath.Ext(path))])
}

// CreateZipArchive function
// CreateZipArchive creates a zip archive of a folder.
func CreateZipArchive(folderPath, outputFilePath string) error {
	zipFile, err := os.Create(outputFilePath)
	if err != nil {
		return fmt.Errorf("error creating zip archive: %v", err)
	}
	defer zipFile.Close()

	zipWriter := zip.NewWriter(zipFile)
	defer zipWriter.Close()

	err = filepath.Walk(folderPath, func(filePath string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if !info.IsDir() {
			relPath, err := filepath.Rel(folderPath, filePath)
			if err != nil {
				return err
			}

			zipEntry, err := zipWriter.Create(relPath)
			if err != nil {
				return err
			}

			file, err := os.Open(filePath)
			if err != nil {
				return err
			}
			defer file.Close()

			_, err = io.Copy(zipEntry, file)
			if err != nil {
				return err
			}
		}
		return nil
	})

	if err != nil {
		return fmt.Errorf("[!] Error creating zip archive: %v", err)
	}

	return nil
}
