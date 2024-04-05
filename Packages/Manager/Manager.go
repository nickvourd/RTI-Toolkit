package Manager

import (
	"Templator/Packages/Colors"
	"Templator/Packages/Utils"
	"fmt"
	"os"
	"time"

	"github.com/fumiama/go-docx"
)

// CreateFile function
func CreateFile(file string, filetype string) {
	switch filetype {
	case "docx":
		// Call function named CreateDocx
		CreateDocx(file)
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

	fmt.Printf("[+] Regular MS Office document successfully created!\n\n[+] Saved to %s\n\n[+] Completed in %s\n\n", Colors.BoldRed(outputAbsolute), RegularDocxDuration)
}
