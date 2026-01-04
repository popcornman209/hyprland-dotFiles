#!/bin/bash
night_temperature=4500
day_temperature=6000


if [[ "$1" == "toggle" ]]; then
	if [[ $(hyprctl hyprsunset temperature) -eq $day_temperature ]]; then
		hyprctl hyprsunset temperature $night_temperature
	else
		hyprctl hyprsunset temperature $day_temperature
	fi
else
	[[ $(hyprctl hyprsunset temperature) -eq $day_temperature ]] && echo '{"alt":"day", "class":"day"}' || echo '{"alt":"night","class":"night"}'
fi
