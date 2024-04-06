package Arguments

import (
	"Templator/Packages/Manager"
	"Templator/Packages/Output"
	"Templator/Packages/Utils"
	"log"
	"os"

	"github.com/spf13/cobra"
)

// templateArgument represents the 'template' command in the CLI.
var templateArgument = &cobra.Command{
	// Use defines how the command should be called.
	Use:          "template",
	Short:        "Inject into an MS Office template document",
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

		// Get all the flags from the 'template' command
		input, _ := cmd.Flags().GetString("input")
		output, _ := cmd.Flags().GetString("output")
		fileType, _ := cmd.Flags().GetString("type")
		link, _ := cmd.Flags().GetString("link")

		// if input is empty
		if input == "" {
			logger.Fatal("The input file is required.")
		} else {
			input = Utils.GetAbsolutePath(input)
		}

		// if link is empty
		if link == "" {
			logger.Fatal("The link is required.")
		}

		// Call function named OutputValidation
		input = Output.OutputValidation(fileType, input, "input")

		// if output is not empty
		if output != "" {
			// Call function named OutputValidation
			output = Output.OutputValidation(fileType, output, "output")
		} else {
			// Set input as output
			output = input
		}

		// Call function named Inject2Template
		Manager.Inject2Template(fileType, input, output, link)

		return nil
	},
}
