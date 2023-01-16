package main

import (
	"fmt"
	"log"
	"os"

	"github.com/amimof/huego"
	"github.com/joho/godotenv"
)

const (
	Office     = 11
	Backdrop   = 5
	LivingRoom = 1
)

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

	fmt.Printf("Triggering colorloop for group: %s\n", group.Name)
}

func turnOn(bridge huego.Bridge, groupID int) {
	group, err := bridge.GetGroup(groupID)
	checkIfErr(err)

	group.On()

	fmt.Printf("Triggering colorloop for group: %s\n", group.Name)
}

func main() {
	bridge := huego.New(env("HUE_IP"), env("HUE_API_KEY"))

  groups, err := bridge.GetGroups()
	checkIfErr(err)

  fmt.Println(groups)

	// createColorloop(*bridge, Office)
	// createColorloop(*bridge, Backdrop)
	// createColorloop(*bridge, LivingRoom)

	// reset(*bridge, Office)
	// reset(*bridge, Backdrop)
	// reset(*bridge, LivingRoom)
}
