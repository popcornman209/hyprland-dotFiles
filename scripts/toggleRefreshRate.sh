#!/bin/bash

if hyprctl monitors | grep -q $'\t2560x1600@165.00000 at'; then
    notify-send -a "hypr" "Refresh rate set to 60"
    hyprctl keyword monitor eDP-1,2560x1600@60,0x0,1.25
else
    hyprctl keyword monitor eDP-1,2560x1600@165,0x0,1.25
    notify-send -a "hypr" "Refresh rate set to 165"
fi

