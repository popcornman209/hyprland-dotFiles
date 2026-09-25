--[[
█▀▄▀█ █▀█ █▄ █ █ ▀█▀ █▀█ █▀█ █▀
█ ▀ █ █▄█ █ ▀█ █  █  █▄█ █▀▄ ▄█

It is setup pretty weird for the main monitor as there are keybinds and daemons that change it between values
the main monitor is customized in the MainMonitor variable, while the rest are in Monitors
at the end DefaultWorkspaces are the default workspaces each monitor is assigned to
]]

MainMonitor = { -- refresh rates to cycle through with mod+shift+r
	["settings"] = { -- main laptop monitor
		output = "eDP-1",
		mode = "2560x1600@",
		position = "0x0",
		scale = 1.25,
	},
	["refresh rates"] = {
		"165.0",
		"60.0",
	},
}

Monitors = { -- no need to include the monitor from RefreshRates
	{
		output = "desc:ASUSTek COMPUTER INC VG28UQL1A 1322131231233",
		mode = "3840x2160@144hz",
		position = "2048x-1024",
		scale = 1.5,
	},
	{
		output = "desc:ASUSTek COMPUTER INC ASUS VG289Q1A R6LMTF137103",
		mode = "3840x2160@60hz",
		position = "4608x-1024",
		scale = 1.5,
	},
}
DefaultWorkspaces = {
	["eDP-1"] = "2", -- laptop screen, when docked off to the left
	["desc:ASUSTek COMPUTER INC VG28UQL1A 1322131231233"] = "1", -- middle
	["desc:ASUSTek COMPUTER INC ASUS VG289Q1A R6LMTF137103"] = "3", -- right
}
