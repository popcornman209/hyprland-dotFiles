--[[
█   █▀▀   █▀▀ █▀█ █▄ █ █▀▀ █ █▀▀ 
█▄▄ █🬰🬭   █▄▄ █▄█ █ ▀█ █▀  █ █▄█ 
 - lua edition :3

theres not much to edit in this file, as this just applies everything for the most part
all other settings are in the files listed below in required_imports (+ ".lua" at the end)
]]

-- TODO:
-- changing hyprland config resets some values, messing with settings_changer
-- get rid of smart placement thing
-- waybar workspace buttons broken
-- notifications only show on one monitor
-- lua refresh rate cycle doesnt work (functions.lua)

local required_imports = {
	"functions",
	"monitors",
	"autostart",
	"keybinds",
	"theme",
}

-- actually import the damn things
for _, import in ipairs(required_imports) do
	require(import)
end

-- if a custom.lua file exists, require it. this is so you can modify your settings without losing ability to git pull.
if DoesFileExist("~/.config/hypr/custom.lua") then
	require("custom")
end

-- keybinds
for keys, action in pairs(Keybinds) do
	local settings = KeybindOptions[keys] or {}
	if type(action) == "string" then
		hl.bind(keys, hl.dsp.exec_cmd(action), settings)
	else
		hl.bind(keys, action, settings)
	end
end
for name, bind in pairs(Workspaces) do
	if type(name) == "number" then
		hl.bind(MainMod .. bind, hl.dsp.focus({ workspace = name }))
		hl.bind(MainMod .. "SHIFT + " .. bind, hl.dsp.window.move({ workspace = name }))
	else
		hl.bind(MainMod .. bind, hl.dsp.workspace.toggle_special(name))
		hl.bind(MainMod .. "SHIFT + " .. bind, hl.dsp.window.move({ workspace = "special:" .. name }))
	end
end

-- apply monitor settings
local main_monitor = MainMonitor["settings"]
main_monitor["mode"] = main_monitor["mode"] .. MainMonitor["refresh rates"][1]
table.insert(Monitors, main_monitor)
for _, monitor in ipairs(Monitors) do
	hl.monitor(monitor)
end
for monitor, workspace in pairs(DefaultWorkspaces) do
	hl.workspace_rule({ workspace = workspace, monitor = monitor, default = true })
end

-- autostart and environment variables
for name, val in pairs(EnvironmentVars) do
	hl.env(name, val)
end
hl.on("hyprland.start", function()
	for _, process in ipairs(AutostartProcesses) do
		hl.exec_cmd(process)
	end
end)

-- same as the other custom.lua file, but this runs after everything so modify anything else here.
if DoesFileExist("~/.config/hypr/custom_append.lua") then
	require("custom_append")
end

Notify("Config", "Config loaded!")
