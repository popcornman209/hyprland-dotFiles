-- ▄▀█ █░█ ▀█▀ █▀█ █▀ ▀█▀ ▄▀█ █▀█ ▀█▀
-- █▀█ █▄█ ░█░ █▄█ ▄█ ░█░ █▀█ █▀▄ ░█░

AutostartProcesses = {
	"awww-daemon", -- wallpaper
	"waybar", -- top bar, mod+b toggles
	"hypridle", -- sleep, locking, etc
	"hyprsunset", -- screen temp filter
	"playerctld", -- for playerctl, detects last played media
	"~/Documents/scripts/settings_changer.py", -- daemon to change settings if device connected
	"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user start hyprland-session.target", --themeing related
	"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1", -- auth agent
}

EnvironmentVars = {
	["XCURSOR_SIZE"] = 24,
	["HYPRCURSOR_SIZE"] = 24,
	["XDG_MENU_PREFIX"] = "arch-",
	["QT_QPA_PLATFORMTHEME"] = "kde",
}
