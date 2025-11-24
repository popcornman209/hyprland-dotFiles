#!/bin/bash
wallpaper="$(swww query | grep -oP 'image: \K.*' | head -n 1)" hyprlock
