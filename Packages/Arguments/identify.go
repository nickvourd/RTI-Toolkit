package Arguments

import (
	"Templator/Packages/Utils"
	"fmt"
	"log"
	"os"

	"github.com/spf13/cobra"
)

// identifyArgument represents the 'identify' command in the CLI.
var identifyArgument = &cobra.Command{
	// Use defines how the command should be called.
	Use:          "identify",
	Short:        "Identify whether the given MS Office document is malicious or not",
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

		// Get all the flags from the 'identify' command
		input, _ := cmd.Flags().GetString("input")
		output, _ := cmd.Flags().GetString("output")

		// if input is empty
		if input == "" {
			logger.Fatal("The input file is required.")
		} else {
			input = Utils.GetAbsolutePath(input)
		}

		fmt.Println(output)

		return nil
	},
}
