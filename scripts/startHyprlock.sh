#!/bin/bash
wallpaper="$(awww query | grep -oP 'image: \K.*' | head -n 1)" hyprlock &
