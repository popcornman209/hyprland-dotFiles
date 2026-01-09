#!/bin/bash

configs=("fastfetch" "hypr" "mako" "rofi" "waybar" "nvim")

echo "copying configs..."
for config in "${configs[@]}"; do
	echo "	copying .config/$config..."
	rsync -a --delete ~/.config/$config config/
done

echo "copying wallpapers..."
cp -r ~/.local/share/wallpapers/* wallpapers/

echo "copying scripts.."
cp -r ~/Documents/scripts/* scripts/

if [[ -n "$1" ]]; then
	echo "updating github..."
	git add .
	git commit -m "$1"
	git push
	echo "uploaded to github..."
else
	echo "no commit supplied, skipping github"
fi
echo "complete!"
