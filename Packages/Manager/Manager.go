package Manager

import (
	"Templator/Packages/Output"
	"Templator/Packages/Utils"
	"log"
	"os"
	"time"

	"github.com/fumiama/go-docx"
	"github.com/xuri/excelize/v2"
)

// CreateFile function
func CreateFile(file string, filetype string) {
	logger := log.New(os.Stderr, "[!] ", 0)
	switch filetype {
	case "docx":
		// Call function named CreateDocx
		CreateDocx(file)
	case "xlsx":
		// Call function named CreateXlsx
		CreateXlsx(file)
	default:
		logger.Fatal("The file type is not supported.")
	}

}

// CreateDocx function
func CreateDocx(file string) {
	// Record the start time
	RegularDocxStartTime := time.Now()

	// Create a new docx instance with default theme
	w := docx.New().WithDefaultTheme()

	// Add a new paragraph
	para1 := w.AddParagraph()

	// Add text to the paragraph
	para1.AddText("Hello World!").Size("35").Bold()

	// Save the document to a file
	f, err := os.Create(file)
	if err != nil {
		panic(err)
	}

	_, err = w.WriteTo(f)
	if err != nil {
		panic(err)
	}

	err = f.Close()
	if err != nil {
		panic(err)
	}

	// Record the end time
	RegularDocxEndTime := time.Now()

	// Call function named GetAbsolutePath
	outputAbsolute := Utils.GetAbsolutePath(file)

	// Calculate the duration
	RegularDocxDuration := RegularDocxEndTime.Sub(RegularDocxStartTime)

	// Call function OutputMessage
	Output.OutputMessage(outputAbsolute, RegularDocxDuration)
}

// CreateXlsx function
func CreateXlsx(file string) {
	// Record the start time
	RegularXlsxStartTime := time.Now()

	// Create a new Excel file
	f := excelize.NewFile()

	// Add a new sheet
	index, _ := f.NewSheet("Sheet1")
	f.SetActiveSheet(index)

	// Add data to the sheet
	f.SetCellValue("Sheet1", "A1", "Hello World!")

	// Save the workbook to a file
	if err := f.SaveAs(file); err != nil {
		panic(err)
	}

	// Record the end time
	RegularXlsxEndTime := time.Now()

	// Call function named GetAbsolutePath
	outputAbsolute := Utils.GetAbsolutePath(file)

	// Calculate the duration
	RegularXlsxDuration := RegularXlsxEndTime.Sub(RegularXlsxStartTime)

	// Call function OutputMessage
	Output.OutputMessage(outputAbsolute, RegularXlsxDuration)
}
