#!/bin/bash
BASE_DIR="$HOME/.local/share/wallpapers"
CURRENT_DIR="$BASE_DIR"

browse() {
    local DIR="$1"
    local ROFI_INPUT=""

    # add parent folder option if not at base
    [[ "$DIR" != "$BASE_DIR" ]] && ROFI_INPUT+="../\n"

    # add directories first
    for D in "$DIR"/*/; do
        [[ -d "$D" ]] || continue
        NAME=$(basename "$D")
        ROFI_INPUT+="$NAME/\n"
    done

    # add image files with icons
    for F in "$DIR"/*; do
        [[ -f "$F" ]] || continue
        [[ "$F" =~ \.jpe?g$|\.png$ ]] || continue
        NAME=$(basename "$F")
        ROFI_INPUT+="$NAME\x00icon\x1f$F\n"
    done

    # show menu
    SELECTED=$(echo -en "$ROFI_INPUT" | rofi -dmenu -i -p "$DIR" -no-custom)
    [[ -z "$SELECTED" ]] && exit 0

    # navigate or set wallpaper
    if [[ "$SELECTED" == "../" ]]; then
        browse "$(dirname "$DIR")"
    elif [[ "$SELECTED" == */ ]]; then
        browse "$DIR/${SELECTED%/}"
    else
        swww img "$DIR/$SELECTED"
    fi
}

browse "$CURRENT_DIR"
