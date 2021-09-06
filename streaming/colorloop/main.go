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

func reset(bridge huego.Bridge, groupID int) {
	group, err := bridge.GetGroup(groupID)
	checkIfErr(err)

	group.Effect("none")
	fmt.Printf("reseting lights in group: %s\n", group.Name)
}

func createColorloop(bridge huego.Bridge, groupID int) {
	group, err := bridge.GetGroup(groupID)
	checkIfErr(err)

	group.Effect("colorloop")
	fmt.Printf("Triggering colorloop for group: %s\n", group.Name)
}

func main() {
	bridge := huego.New(env("HUE_IP"), env("HUE_API_KEY"))

	createColorloop(*bridge, Office)
	createColorloop(*bridge, Backdrop)
	createColorloop(*bridge, LivingRoom)

	// reset(*bridge, Office)
	// reset(*bridge, Backdrop)
	// reset(*bridge, LivingRoom)
}
