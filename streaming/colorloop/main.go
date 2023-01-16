package main

import (
	"fmt"
	"log"
	"os"
	"strconv"

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

func toInt (input string) int {
  marks, err := strconv.Atoi(input)
	checkIfErr(err)
  return marks
}

func off(bridge huego.Bridge, groupID int) {
	group, err := bridge.GetGroup(groupID)
	checkIfErr(err)

  group.Off()

	fmt.Printf("reseting lights in group: %s\n", group.Name)
}

func createEffect(bridge huego.Bridge, lights []string, effect string) {
  for i := 0; i < len(lights); i++ {
    id := toInt(lights[i])

    light, err := bridge.GetLight(id)
    checkIfErr(err)

    if (light.Type == "Extended color light") {
      light.Effect(effect)
    }

    if (light.Type == "On/Off plug-in unit") {
      light.Off()
    }
  }
}

func reset(bridge huego.Bridge, groupID int) {
	group, err := bridge.GetGroup(groupID)
	checkIfErr(err)

  createEffect(bridge, group.Lights, "none")

	fmt.Printf("reseting lights in group: %s\n", group.Name)
}

func createColorloop(bridge huego.Bridge, groupID int) {
	group, err := bridge.GetGroup(groupID)
	checkIfErr(err)

  createEffect(bridge, group.Lights, "colorloop")

	fmt.Printf("Triggering colorloop for group: %s\n", group.Name)
}

func main() {
	bridge := huego.New(env("HUE_IP"), env("HUE_API_KEY"))

	state := os.Args[1:][0]
	switch state {
	case "on":
    createColorloop(*bridge, Office)
    createColorloop(*bridge, Backdrop)
    createColorloop(*bridge, LivingRoom)
	case "reset":
    reset(*bridge, Office)
    reset(*bridge, Backdrop)
    reset(*bridge, LivingRoom)
	case "off":
    off(*bridge, Office)
    off(*bridge, Backdrop)
    off(*bridge, LivingRoom)
	}
}
