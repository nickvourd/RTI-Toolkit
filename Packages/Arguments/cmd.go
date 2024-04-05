package Arguments

import (
	"Templator/Packages/Colors"
	"fmt"
	"log"
	"os"

	"github.com/spf13/cobra"
)

var (
	__ascii__ = `
___________                   .__          __                
\__    ___/___   _____ ______ |  | _____ _/  |_  ___________ 
  |    |_/ __ \ /     \\____ \|  | \__  \\   __\/  _ \_  __ \
  |    |\  ___/|  Y Y  \  |_> >  |__/ __ \|  | (  <_> )  | \/
  |____| \___  >__|_|  /   __/|____(____  /__|  \____/|__|   
             \/      \/|__|             \/                   
`
	__version__      = "2.0"
	__version_name__ = "Owl Hunter"
	__authors__      = "@nickvourd"
	__license__      = "MIT"
	__github__       = "https://github/nickvourd/RTI-Toolkit"

	text = `
Templator v%s - Remote Template Injection Tool.
Templator is an open source tool licensed under %s.
Written with <3 by %s.
Please visit %s for more...

`
	TemplatorCli = &cobra.Command{
		Use:          "Templator",
		SilenceUsage: true,
		RunE:         StartTemplator,
	}
)

// init function
// init all flags.
func init() {
	// Disable default command completion for Templator CLI.
	TemplatorCli.CompletionOptions.DisableDefaultCmd = true

	// Add commands to the Templator CLI.
	TemplatorCli.Flags().SortFlags = true
	TemplatorCli.Flags().BoolP("version", "v", false, "Show Templator current version")
	TemplatorCli.AddCommand(templateArgument)
	TemplatorCli.AddCommand(regularArgument)
	TemplatorCli.AddCommand(ctemplateArgument)
	TemplatorCli.AddCommand(cregularArgument)
	TemplatorCli.AddCommand(identifyArgument)
	TemplatorCli.AddCommand(fileTypeArgument)

	// Add flags to specific commands
	// for cregular command
	cregularArgument.Flags().StringP("output", "o", "", "Set output file")
	cregularArgument.Flags().StringP("type", "t", "docx", "Set file type (i.e., docx, xlsx)")
}

// ShowAscii function
func ShowAscii() {
	// Initialize RandomColor
	randomColor := Colors.RandomColor()
	fmt.Print(randomColor(__ascii__))
	fmt.Printf(text, __version__, __license__, __authors__, __github__)
}

// ShowVersion function
func ShowVersion(versionFlag bool) {
	// if one argument
	if versionFlag {
		// if version flag exists
		fmt.Printf("[+] Current version: " + Colors.BoldRed(__version__) + "\n\n[+] Version name: " + Colors.BoldRed(__version_name__) + "\n\n")
		os.Exit(0)
	}
}

// StartTemplator function
func StartTemplator(cmd *cobra.Command, args []string) error {
	logger := log.New(os.Stderr, "[!] ", 0)

	// Call function named ShowAscii
	ShowAscii()

	// Check if additional arguments were provided.
	if len(os.Args) == 1 {
		// Display help message.
		err := cmd.Help()

		// If error exists
		if err != nil {
			logger.Fatal("Error:", err)
			return err
		}
	}

	// Obtain flag
	versionFlag, _ := cmd.Flags().GetBool("version")

	// Call function named ShowVersion
	ShowVersion(versionFlag)

	return nil
}
