package Arguments

import (
	"log"
	"os"

	"github.com/spf13/cobra"
)

// regularArgument represents the 'regular' command in the CLI.
var regularArgument = &cobra.Command{
	// Use defines how the command should be called.
	Use:          "regular",
	Short:        "Inject into a regular MS Office document (Without template)",
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
