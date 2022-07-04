#!/bin/bash

battery() {
  local batt discharging percentage charge

  if [[ $(uname) == "Linux" ]]; then
    batt0=/sys/class/power_supply/BAT0
    batt=$(acpi -b 2> /dev/null | awk '/Battery 0/{print $4}' | cut -d, -f1)
    # discharging=$(grep -qi "discharging" ${batt}/status && echo "true" || echo "false")
  elif [[ $(uname) == "Darwin" ]]; then
    batt="$(pmset -g batt)"
    # discharging="$(echo "${batt}" | grep -qi "discharging" && echo "true" || echo "false")"
  else
    return 1
  fi

  echo $batt
}

battery "$@"
