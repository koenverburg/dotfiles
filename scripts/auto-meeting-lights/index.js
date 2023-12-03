import isCameraOn from "is-camera-on";
import { execSync } from "child_process";

const state = {
  triggered: false
}

async function main() {
  const status = await isCameraOn()
  console.log({ status })

  if (status === true && !state.triggered) {
    state.triggered = true
    execSync('shortcuts run "Keylights On"');
    console.log('Starting')

  } else if (status === false & state.triggered) {
    state.triggered = false
    execSync('shortcuts run "Keylights Off"');
    console.log('Closing')
  }
}

// main()
setInterval(main, 1000)
