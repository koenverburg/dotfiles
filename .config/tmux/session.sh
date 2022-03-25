#!/bin/bash

tmux list-sessions -F '#S' \
  | awk 'BEGIN {ORS=" "} {print $1, NR, "\"switch-client -t", $1 "\""}' \
  | xargs tmux display-menu -T "Switch-session"
