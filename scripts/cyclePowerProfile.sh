#!/bin/bash

profile=$(powerprofilesctl get)

if [[ "$profile" == "power-saver" ]]; then
	powerprofilesctl set balanced
elif [[ "$profile" == "balanced" ]]; then
	powerprofilesctl set performance
elif [[ "$profile" == "performance" ]]; then
	powerprofilesctl set power-saver
fi
