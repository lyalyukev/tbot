/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/spf13/cobra"
	telebot "gopkg.in/telebot.v3"
)

var Teletoken = os.Getenv("TELE_TOKEN")
var appVersion = "version"

// startCmd represents the start command
var startCmd = &cobra.Command{
	Use:   "start",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {

		fmt.Printf("Telebot %s started", appVersion)

		pref := telebot.Settings{
			Token:  Teletoken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		}

		kbot, err := telebot.NewBot(pref)

		if err != nil {
			log.Fatalf("Plaese check TELE_TOKEN env variable. %s", err)
			return
		}

		kbot.Handle(telebot.OnText, func(c telebot.Context) error {
			fmt.Println(c.Message().Payload, c.Text())
			text := c.Text()

			if text == "/hello" {
				return c.Send("Received command Hello")
			}

			return nil
		})

		kbot.Start()
		
	},
}

func init() {
	rootCmd.AddCommand(startCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// startCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// startCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
