#!/bin/bash

# get current state
output=$(hyprctl getoption $1)

# get the value of "int" (the current state with 1 being true and 0 false)
int=$(echo "$output" | grep '^int:' | awk '{print $2}')

# turn said int into a "true" or "false" string
newValue=$( [[ $int -eq 0 ]] && echo true || echo false )

# make the actual change
hyprctl keyword $1 "$newValue"

# let you know
notify-send -a "hypr" "keyword changed" "$1: $newValue"
