#!/bin/bash

CHOICE=$(printf "Hyprland\nWaybar\nScripts\nFish" | rofi -dmenu -p "Configuration")

case "$CHOICE" in
  Hyprland)
    code ~/.config/hypr
    ;;
  Waybar)
    code ~/.config/waybar
    ;;
  Scripts)
  	code ~/Documents/scripts
  	;;
  Fish)
    code ~/.config/fish/config.fish
    ;;
  *)
  	echo nothing selected
    ;;
esac
