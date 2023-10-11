package main

import (
	"encoding/json"
	"fmt"
	"image/color"
	"log"
	"math"
	"os"
	"strconv"
	"strings"

	"github.com/amimof/huego"
	"github.com/joho/godotenv"
)

const (
	Studio         = 81
	Plug           = 20
	HairLight      = 18
	Backdrop1left  = 17
	Backdrop2right = 16
)

func toInt(input string) int {
	marks, err := strconv.Atoi(input)
	checkIfErr(err)
	return marks
}

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

func ConvertRGBToXy(newcolor color.Color) ([]float32, uint8) {
	r, g, b, _ := newcolor.RGBA()
	rf := float64(r) / 65536.0
	gf := float64(g) / 65536.0
	bf := float64(b) / 65536.0

	rf = gammaCorrect(rf)
	gf = gammaCorrect(gf)
	bf = gammaCorrect(bf)

	X := float32(rf*0.649926 + gf*0.103455 + bf*0.197109)
	Y := float32(rf*0.234327 + gf*0.743075 + bf*0.022598)
	Z := float32(rf*0.0000000 + gf*0.053077 + bf*1.035763)

	x := X / (X + Y + Z)
	y := Y / (X + Y + Z)

	xy := []float32{x, y}
	return xy, uint8(Y * 254)
}

func gammaCorrect(value float64) float64 {
	if value > 0.04045 {
		return math.Pow((value+0.055)/(1.0+0.055), 2.4)
	}
	return (value / 12.92)
}

func hexToRGB(hex string) (color.RGBA, error) {
	hex = strings.TrimPrefix(hex, "#")

	// Parse the hex string into RGB values
	rgb, err := strconv.ParseUint(hex, 16, 32)
	if err != nil {
		return color.RGBA{}, err
	}

	// Extract individual color components
	red := uint8((rgb >> 16) & 0xFF)
	green := uint8((rgb >> 8) & 0xFF)
	blue := uint8(rgb & 0xFF)

	return color.RGBA{red, green, blue, 255}, nil
}

func checkIfErr(err error) {
	if err != nil {
		panic(err)
	}
}

func turnOn(bridge huego.Bridge, Id int) *huego.Light {
	light, err := bridge.GetLight(Id)
	checkIfErr(err)

	light.On()

	fmt.Printf("Turning on Light: %s\n", light.Name)

	return light
}

func turnOnColorloop(bridge huego.Bridge, lightID int) {
	light := turnOn(bridge, lightID)
	light.Effect("colorloop")

}

func turnOnColor(bridge huego.Bridge, lightID int, hex string) {
	light := turnOn(bridge, lightID)
	light.Effect("colorloop")
}

func turnOff(bridge huego.Bridge, groupID int) {
	group, err := bridge.GetGroup(groupID)
	checkIfErr(err)

	group.Off()

	fmt.Printf("Turning on group: %s\n", group.Name)
}

func reset(bridge huego.Bridge, groupID int) {
	group, err := bridge.GetGroup(groupID)
	checkIfErr(err)
	// createEffect(bridge, group.Lights, "none")
	fmt.Printf("reseting lights in group: %s\n", group.Name)
}

func main() {
	bridge := huego.New(env("HUE_IP"), env("HUE_API_KEY"))
	state := os.Args[1:][0]

	switch state {
	case "keylight":
		turnOn(*bridge, Plug)
	case "off":
		turnOff(*bridge, Studio)
	case "all":
		turnOn(*bridge, Plug)
		turnOn(*bridge, HairLight)
		turnOn(*bridge, Backdrop1left)
		turnOn(*bridge, Backdrop2right)
	case "colorloop":
		turnOnColorloop(*bridge, HairLight)
		turnOnColorloop(*bridge, Backdrop1left)
		turnOnColorloop(*bridge, Backdrop2right)
	case "colorloop-all":
		turnOn(*bridge, Plug)
		turnOnColorloop(*bridge, HairLight)
		turnOnColorloop(*bridge, Backdrop1left)
		turnOnColorloop(*bridge, Backdrop2right)
	case "red":
		turnOnColor(*bridge, HairLight, "#ff000")
		turnOnColor(*bridge, Backdrop1left, "#ff000")
		turnOnColor(*bridge, Backdrop2right, "#ff000")
	}
}
