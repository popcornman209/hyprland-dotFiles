#!/bin/bash

CHOICE=$(printf "Shutdown\nReboot\nExit Hyprland" | rofi -dmenu -p "Power")

case "$CHOICE" in
  Shutdown)
    shutdown now
    ;;
  Reboot)
    reboot
    ;;
  "Exit Hyprland")
  	hyprctl dispatch exit
 	;;
  *)
  	echo nothing selected
    ;;
esac
