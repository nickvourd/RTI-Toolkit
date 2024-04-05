package Arguments

import (
	"Templator/Packages/Manager"
	"Templator/Packages/Output"
	"log"
	"os"

	"github.com/spf13/cobra"
)

// cregularArgument represents the 'cregular' command in the CLI.
var cregularArgument = &cobra.Command{
	// Use defines how the command should be called.
	Use:          "cregular",
	Short:        "Create a new regular MS Office document (Without template)",
	SilenceUsage: true,

	// RunE defines the function to run when the command is executed.
	RunE: func(cmd *cobra.Command, args []string) error {
		logger := log.New(os.Stderr, "[!] ", 0)

		// Call function named ShowAscii
		ShowAscii()

		// Check if additional arguments were provided.
		if len(os.Args) <= 2 {
			// Show help message.
			err := cmd.Help()
			if err != nil {
				logger.Fatal("Error", err)
				return err
			}

			// Exit the program.
			os.Exit(0)
		}

		// Get the value of any flag
		output, _ := cmd.Flags().GetString("output")
		fileType, _ := cmd.Flags().GetString("type")

		// If output is empty
		if output == "" {
			logger.Fatal("The '-o' or '--output' flag is required for the command to proceed.")
		}

		// Call function named OutputValidation
		output = Output.OutputValidation(fileType, output, "output")

		// Call function CreateFile
		Manager.CreateFile(output, fileType)

		return nil
	},
}
