#!/bin/bash

configs=("fastfetch" "hypr" "mako" "rofi" "waybar" "nvim")

echo "copying configs..."
for config in "${configs[@]}"; do
	echo "	copying .config/$config..."
	cp -r ~/.config/$config config/
done

echo "copying wallpapers..."
cp -r ~/.local/share/wallpapers/* wallpapers/

echo "copying scripts.."
cp -r ~/Documents/scripts/* scripts/

if [[ -n "$1" ]]; then
	git add .
	git commit -m "$1"
	git push
fi
