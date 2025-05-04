#!/bin/bash

# Check if Waybar is running
if pgrep waybar > /dev/null; then
    # If running, kill it
    pkill waybar
else
    # If not running, start it
    waybar &
fi
