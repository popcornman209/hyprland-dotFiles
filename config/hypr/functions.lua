-- █▀▀ █ █ █▄ █ █▀▀ ▀█▀ █ █▀█ █▄ █ █▀
-- █▀  █▄█ █ ▀█ █▄▄  █  █ █▄█ █ ▀█ ▄█

function Notify(title, message)
	hl.exec_cmd('notify-send -a "hypr" "' .. title .. '" "' .. message .. '"')
end

local touchpad_disabled_while_typing = true
function ToggleTouchpadWhileTyping()
	touchpad_disabled_while_typing = not touchpad_disabled_while_typing
	hl.config({
		input = {
			touchpad = {
				disable_while_typing = touchpad_disabled_while_typing,
			},
		},
	})
	Notify("Setting", "Touchpad disabled while typing: " .. tostring(touchpad_disabled_while_typing))
end

local animations_enabled = true
function ToggleAnimations()
	animations_enabled = not animations_enabled
	hl.config({
		animations = {
			enabled = animations_enabled,
		},
	})
	Notify("Setting", "Animations: " .. tostring(animations_enabled))
end

-- got this from https://github.com/end-4/dots-hyprland/blob/main/dots/.config/hypr/hyprland/lib/init.lua
function is_file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- TODO: make this... work... (currently uses settings_changer.py)
local currentRefreshRateID = 1
function CycleMainMonitor()
	local rate = MainMonitor["refresh rates"][currentRefreshRateID]
	currentRefreshRateID = (currentRefreshRateID % #MainMonitor["refresh rates"]) + 1
	local monitor = MainMonitor["settings"]
	monitor["mode"] = monitor["mode"] .. rate
	hl.monitor(monitor)
	Notify("Setting", "Refresh rate set to " .. rate)
end

-- bring windows off screen back to the mouse
function FindOffscreenWindows() -- this function was mostly ai generated, I don't have time for something this stupid
	local monitors = hl.get_monitors()
	local cursor = hl.get_cursor_pos()

	for _, w in ipairs(hl.get_windows()) do
		local onscreen = false
		for _, m in ipairs(monitors) do
			if w.at.x >= m.x and w.at.x < m.x + m.width and w.at.y >= m.y and w.at.y < m.y + m.height then
				onscreen = true
				break
			end
		end

		if not onscreen and cursor ~= nil then
			local addr = "address:" .. w.address
			hl.dispatch(hl.dsp.window.move({
				window = addr,
				x = cursor.x - 50,
				y = cursor.y - 50,
			}))
			hl.dispatch(hl.dsp.focus({ window = addr }))
		end
	end
	Notify("Window off screen", "window brought to mouse!")
end
