package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"

	"github.com/amimof/huego"
	"github.com/joho/godotenv"
)

const (
	Studio = 11
	Plug   = 14
)

func prettyString(in interface{}) {
	b, err := json.MarshalIndent(in, "", "  ")
	if err != nil {
		fmt.Println(err)
	}
	fmt.Print(string(b))
}

func env(key string) string {
	if os.Getenv("ENV") == "prod" {
		return os.Getenv(key)
	}

	err := godotenv.Load(".env")
	if err != nil {
		log.Fatalf("Error loading .env file")
	}

	return os.Getenv(key)
}

func checkIfErr(err error) {
	if err != nil {
		panic(err)
	}
}

func turnOff(bridge huego.Bridge, groupID int) {
	group, err := bridge.GetGroup(groupID)
	checkIfErr(err)

	group.Off()

	fmt.Printf("Turning on group: %s\n", group.Name)
}

func turnOn(bridge huego.Bridge, groupID int) {
	group, err := bridge.GetGroup(groupID)
	checkIfErr(err)

	// group.On()

  // Studio Id and led strip have the same ID
	light, err := bridge.GetLight(Studio)
	light.Off()

	plug, err := bridge.GetLight(Plug)
	checkIfErr(err)

	plug.On()

	fmt.Printf("Turning off group: %s\n", group.Name)
}

func main() {
	bridge := huego.New(env("HUE_IP"), env("HUE_API_KEY"))

	state := os.Args[1:][0]
	switch state {
	case "on":
		turnOn(*bridge, Studio)
	case "off":
		turnOff(*bridge, Studio)
	}
}
