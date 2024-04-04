package Arguments

import (
	"log"
	"os"

	"github.com/spf13/cobra"
)

// ctemplateArgument represents the 'ctemplate' command in the CLI.
var ctemplateArgument = &cobra.Command{
	// Use defines how the command should be called.
	Use:          "ctemplate",
	Short:        "Create a new MS Office template document",
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

		return nil
	},
}
