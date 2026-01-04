#!/bin/bash

EDITOR="kitty -e nvim"
# EDITOR="code"
# EDITOR="zeditor"

CHOICE=$(printf "Hyprland\nWaybar\nScripts\nFish" | rofi -dmenu -p "Configuration")

case "$CHOICE" in
  Hyprland)
    eval "$EDITOR ~/.config/hypr"
    ;;
  Waybar)
    eval "$EDITOR ~/.config/waybar"
    ;;
  Scripts)
  	eval "$EDITOR ~/Documents/scripts"
  	;;
  Fish)
    eval "$EDITOR ~/.config/fish/config.fish"
    ;;
  *)
  	echo nothing selected
    ;;
esac
