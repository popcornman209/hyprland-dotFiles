set fish_greeting

if status --is-interactive
    echo -e
    fastfetch --config examples/8

    alias ff="clear && fastfetch"
    alias venvActv="source venv/bin/activate.fish"

    alias keyboardPermFix="~/Documents/scripts/fix-input-perms.sh Framework_Laptop_16 && ~/Documents/scripts/fix-input-perms.sh Keychron"
    alias dolphinFix="XDG_MENU_PREFIX=arch- kbuildsycoca6"

    function webp2png
        magick $argv[1] (string replace -r '\.webp$' '.png' $argv[1])
    end

    # load custom.fish file for custom fish stuff
    test -f ~/.config/fish/custom.fish; and source ~/.config/fish/custom.fish
end
