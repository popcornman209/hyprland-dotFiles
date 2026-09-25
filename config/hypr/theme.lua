-- ▀█▀ █ █ █▀▀ █▀▄▀█ █▀▀   ▄ ▀▀█
--  █  █▀█ █🬰🬭 █ ▀ █ █🬰🬭   ▄ 🬭🬰█

-- the below colors are from the catppuccin mocha color pallet here:
-- https://catppuccin.com/palette/
-- catppucin my beloved :3

local colors = {
	["active border 1"] = "#f5c2e7", -- 'pink'
	["active border 2"] = "#89b4fa", -- 'blue'
	["inactive border"] = "#313244", -- 'surface 0'
	["shadow"] = "#11111b", -- 'crust'
}

hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 5,
		border_size = 3,
		allow_tearing = false,
		col = {
			active_border = { colors = { colors["active border 1"], colors["active border 2"] }, angle = 270 },
			inactive_border = colors["inactive border"],
		},
	},
	decoration = {
		rounding = 10,
		active_opacity = 0.95,
		inactive_opacity = 0.90,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = colors["shadow"],
		},
		blur = {
			enabled = true,
			size = 12,
			passes = 2,
		},
	},
	dwindle = {
		preserve_split = true,
		smart_split = true,
	},
	xwayland = {
		force_zero_scaling = true,
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
})

-- ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█ █▀
-- █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█ ▄█

hl.curve("myBezier", {
	type = "bezier",
	points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
})
hl.curve("linear", {
	type = "bezier",
	points = { { 0.0, 0.0 }, { 1.0, 1.0 } },
})
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "linear", style = "loop" })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 6, bezier = "default", style = "slidevert top" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 6, bezier = "default", style = "slidevert bottom" })
