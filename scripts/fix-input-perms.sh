#!/bin/bash

# Check if an argument is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <device-name>"
    exit 1
fi

# Search term
SEARCH_TERM="$1"

# Get all matching items in /dev/input/by-id/
for item in /dev/input/by-id/*"$SEARCH_TERM"*; do
    # Ensure the file exists (in case no match is found)
    [[ -e "$item" ]] || continue

    # Resolve the actual device path
    device_path=$(readlink -f "$item")

    # Check if the resolved path exists
    if [[ -e "$device_path" ]]; then
        echo "Changing permissions for: $device_path"
        sudo chmod 666 "$device_path"
    else
        echo "Skipping: $item (could not resolve)"
    fi
done
