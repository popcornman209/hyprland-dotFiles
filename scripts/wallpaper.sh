#1/bin/bash
DIR="$HOME/.local/share/wallpapers"
SELECTED=$(basename -a "$DIR"/* | rofi -dmenu -p "Wallpaper")
swww img "$DIR/$SELECTED"
