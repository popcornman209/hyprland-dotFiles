#!/bin/bash

CHOICE=$(printf "Lock\nSuspend\nShutdown\nReboot\nExit Hyprland" | rofi -dmenu -p "Power")

case "$CHOICE" in
  Lock)
    loginctl lock-session
    ;;
  Suspend)
    systemctl suspend
    ;;
  Shutdown)
    shutdown now
    ;;
  Reboot)
    reboot
    ;;
  "Exit Hyprland")
  	hyprctl dispatch 'hl.dsp.exit()'
 	;;
  *)
  	echo nothing selected
    ;;
esac
