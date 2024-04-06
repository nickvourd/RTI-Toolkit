package Output

import (
	"Templator/Packages/Colors"
	"fmt"
	"log"
	"os"
	"strings"
	"time"
)

// AddExtension function
func AddExtension(extension string, output string, statement string) string {
	// Decalre varaibles
	var addExtension string = output

	// Add extension to output
	addExtension = output + extension
	fmt.Printf("[!] Added the '%s' extension to %s %s file\n\n", extension, output, statement)

	return addExtension
}

// OutputValidation function
func OutputValidation(fileType string, input string, statement string) string {
	logger := log.New(os.Stderr, "[!] ", 0)

	switch fileType {
	case "docx":
		if !strings.HasSuffix(strings.ToLower(input), ".docx") {
			// Call function named AddExtension
			input = AddExtension(".docx", input, statement)
		}
	case "xlsx":
		if !strings.HasSuffix(strings.ToLower(input), ".xlsx") {
			// Call function named AddExtension
			input = AddExtension(".xlsx", input, statement)
		}
	case "pptx":
		if !strings.HasSuffix(strings.ToLower(input), ".pptx") {
			// Call function named AddExtension
			input = AddExtension(".pptx", input, statement)
		}
	default:
		logger.Fatal("The file type is not supported.")
		return ""
	}

	return input
}

// OutputMessage function
func OutputRegularMessage(path string, duration time.Duration) {
	fmt.Printf("[+] Regular MS Office document successfully created!\n\n[+] Saved to %s\n\n[+] Completed in %s\n\n", Colors.BoldRed(path), duration)
}

// SetOutput function
func SetOutput(zipFile string, statement string) {
	logger := log.New(os.Stderr, "[!] ", 0)

	err := os.Rename(zipFile, statement)
	if err != nil {
		logger.Fatal("Error: ", err)
	}
}
