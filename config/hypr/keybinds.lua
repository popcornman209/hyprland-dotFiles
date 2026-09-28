MainMod = "SUPER + "

Keybinds = {
	-- ▄▀█ █▀█ █▀█ █▀
	-- █▀█ █▀▀ █▀▀ ▄█
	[MainMod .. "T"] = "kitty", -- terminal
	[MainMod .. "E"] = "dolphin", -- file explorer
	[MainMod .. "F"] = "firefox -profile ~/.mozilla/firefox/84as5w2r.default-release --no-remote", -- browser
	[MainMod .. "ALT + F"] = 'firefox --profile "/home/leo/.mozilla/firefox/MZxqW4Ml.Profile 1" --no-remote', -- alt browser profile
	[MainMod .. "C"] = "code", -- code editor
	[MainMod .. "A"] = "rofi -show drun", -- app launcher
	[MainMod .. "D"] = "vesktop", -- discord client
	[MainMod .. "M"] = "spotify", -- music
	[MainMod .. "G"] = "steam", -- game launcher

	-- █▀█ █▀█ █ █ █ █▀▀ █▀█
	-- █▀▀ █▄█ ▀▄▀▄▀ █🬰🬭 █▀▄
	[MainMod .. "ESCAPE"] = "loginctl lock-session", -- lock screen
	[MainMod .. "SHIFT + ESCAPE"] = ScriptsFolder .. "power.sh", -- power menu
	["XF86Launch5"] = "playerctl pause & loginctl lock-session", -- lock screen and pause (f14)
	["XF86Launch6"] = "playerctl pause & systemctl suspend", -- keyboard suspend button (f15)

	-- █ █ █ █ █▄ █ █▀▄ █▀█ █ █ █
	-- ▀▄▀▄▀ █ █ ▀█ █▄▀ █▄█ ▀▄▀▄▀
	[MainMod .. "Q"] = hl.dsp.window.close(),
	[MainMod .. "W"] = hl.dsp.window.float(), -- make window float
	[MainMod .. "SHIFT + F"] = hl.dsp.window.fullscreen(), -- fullscreen window
	[MainMod .. "mouse:272"] = hl.dsp.window.drag(),
	[MainMod .. "mouse:273"] = hl.dsp.window.resize(),
	[MainMod .. "Z"] = hl.dsp.window.drag(),
	[MainMod .. "X"] = hl.dsp.window.resize(),
	[MainMod .. "mouse_left"] = hl.dsp.focus({ workspace = "e-1" }),
	[MainMod .. "mouse_right"] = hl.dsp.focus({ workspace = "e+1" }),
	[MainMod .. "SHIFT + mouse_left"] = hl.dsp.window.move({ workspace = "e-1" }),
	[MainMod .. "SHIFT + mouse_right"] = hl.dsp.window.move({ workspace = "e+1" }),

	-- ▀█▀ █▀█ █▀▀ █▀▀ █   █▀▀ █▀
	--  █  █▄█ █▄█ █▄█ █▄▄ █🬰🬭 ▄█
	[MainMod .. "V"] = "~/.config/waybar/scripts/toggleVpn.sh", -- toggle vpn
	[MainMod .. "B"] = ScriptsFolder .. "toggleWaybar.sh", -- toggle waybar
	[MainMod .. "N"] = ScriptsFolder .. "hyprsunset.sh toggle", -- screen temperature filter
	[MainMod .. "P"] = ScriptsFolder .. "settings_changer/main.py -pc", -- power profile cycle
	[MainMod .. "K"] = ToggleTouchpadWhileTyping, -- toggle touchpad while typing
	[MainMod .. "SHIFT + A"] = ToggleAnimations, -- toggle animations
	[MainMod .. "SHIFT + R"] = ScriptsFolder .. "settings_changer/main.py -rc", -- cycle refresh rates

	-- ▀█▀ █▀█ █▀█ █   █▀
	--  █  █▄█ █▄█ █▄▄ ▄█
	[MainMod .. "SHIFT + P"] = "hyprpicker -a", -- color picker
	["Print"] = "grimblast --freeze copy area", -- screenshot
	["XF86Explorer"] = ScriptsFolder .. "wallpaper.sh", -- wallpaper picker
	["XF86Tools"] = ScriptsFolder .. "configure.sh", -- quick edit config files
	[MainMod .. "SHIFT + O"] = FindOffscreenWindows, -- find windows that went off screen, made to fix a openrocket bug
	[MainMod .. "SHIFT + B"] = ScriptsFolder .. "big_font.py -r",

	-- █▀▀   █▄▀ █▀▀ █▄█ █▀
	-- █▀    █ █ █🬰🬭  █  ▄█
	--media
	["XF86AudioPlay"] = "playerctl play-pause",
	["XF86AudioStop"] = "playerctl pause",
	["XF86AudioNext"] = "playerctl next",
	["XF86AudioPrev"] = "playerctl previous",
	--volume
	["XF86AudioLowerVolume"] = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", -- vol -
	["XF86AudioRaiseVolume"] = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+", -- vol +
	["XF86AudioMute"] = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", -- vol toggle
	["XF86AudioMicMute"] = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", -- mic toggle
	[MainMod .. "XF86AudioLowerVolume"] = "playerctl --player spotify volume .05-", -- spotify lower vol
	[MainMod .. "XF86AudioRaiseVolume"] = "playerctl --player spotify volume .05+", -- spotify raise vol
	--brightness
	["XF86MonBrightnessDown"] = "brightnessctl set 10%-",
	["XF86MonBrightnessUp"] = "brightnessctl set 10%+",
}

KeybindOptions = {
	[MainMod .. "mouse:272"] = { mouse = true },
	[MainMod .. "mouse:273"] = { mouse = true },
	-- f keys
	["XF86AudioLowerVolume"] = { repeating = true },
	["XF86AudioRaiseVolume"] = { repeating = true },
	[MainMod .. "XF86AudioLowerVolume"] = { repeating = true },
	[MainMod .. "XF86AudioRaiseVolume"] = { repeating = true },
	["XF86MonBrightnessDown"] = { repeating = true },
	["XF86MonBrightnessUp"] = { repeating = true },
}

-- █ █ █ █▀█ █▀█ █▄▀ █▀ █▀█ ▄▀█ █▀▀ █▀▀ █▀
-- ▀▄▀▄▀ █▄█ █▀▄ █ █ ▄█ █▀▀ █▀█ █▄▄ █🬰🬭 ▄█
Workspaces = { -- ["name"] = "bind"
	[1] = "1",
	[2] = "2",
	[3] = "3",
	[4] = "4",
	[5] = "5",
	[6] = "6",
	[7] = "7",
	[8] = "8",
	[9] = "9",
	[10] = "0",
	["main"] = "s",
	["minimize"] = "code:49", -- where i throw useless windows that have to be open
}

-- █▀▀ █▀▀ █▀ ▀█▀ █ █ █▀█ █▀▀ █▀
-- █▄█ █🬰🬭 ▄█  █  █▄█ █▀▄ █🬰🬭 ▄█
hl.gesture({ fingers = 4, direction = "down", action = "special", workspace_name = "main" })
hl.gesture({ fingers = 4, scale = 2, direction = "horizontal", action = "workspace" })

hl.config({
	input = {
		touchpad = {
			clickfinger_behavior = true,
		},
	},
	binds = {
		scroll_event_delay = 0, -- or try 10-20 if 0 causes double-triggers
	},
	gestures = {
		workspace_swipe_invert = false,
	},
})
