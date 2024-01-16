----------------------------------------------------------------------------
--- Wallpaper Blurring Script
--
-- @author William McKinnon
-- @editor Strikoder
-- @module wallpaper
--
--- Enjoy!
----------------------------------------------------------------------------


--      ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗
--      ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
--      ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
--      ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
--      ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
--       ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝


-- ===================================================================
-- Imports
-- ===================================================================


local awful = require("awful")
awful.spawn.with_shell("nitrogen --restore")
local gears = require("gears")
local naughty = require("naughty")
local config_dir = gears.filesystem.get_configuration_dir()


-- ===================================================================
-- Initialization
-- ===================================================================


local blurred = false;

local wallpaper = config_dir .. "/wallpaper/bg1.jpg"
local blurredWallpaper = config_dir .. "/blurredWallpaper.png"

--- Check if a file or directory exists in this path
local function exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

-- check if blurred wallpaper needs to be created
if not exists(blurredWallpaper) then
	naughty.notify({
		preset = naughty.config.presets.normal,
		title = 'Wallpaper',
		text = 'Generating blurred wallpaper...'
	})
	-- uses image magick to create a blurred version of the wallpaper
	awful.spawn.with_shell("convert -filter Gaussian -blur 0x15 " .. wallpaper .. " " .. blurredWallpaper)
end


-- ===================================================================
-- Functionality
-- ===================================================================


-- Helper function to get the focused monitor
local function get_focused_monitor()
	local focused_screen = awful.screen.focused()
	return focused_screen and focused_screen.index or nil
end

-- changes to blurred wallpaper
local function blur()
	if not blurred and get_focused_monitor() == 1 then -- Assuming DP-0 is monitor 1
		awful.spawn.with_shell("nitrogen --set-zoom-fill " .. blurredWallpaper .. " --head=0")
		blurred = true
	end
end

-- changes to normal wallpaper
local function unblur()
	if blurred then
		awful.spawn.with_shell("nitrogen --restore")
		blurred = false
	end
end

-- blur / unblur on tag change
tag.connect_signal('property::selected', function(t)
	if get_focused_monitor() == 1 then
		-- if tag has clients
		for _ in pairs(t:clients()) do
			blur()
			return
		end
		-- if tag has no clients
		unblur()
	end
end)

-- check if wallpaper should be blurred on client open
client.connect_signal("manage", function(c)
	blur()
end)

-- check if wallpaper should be unblurred on client close
client.connect_signal("unmanage", function(c)
	local t = awful.screen.focused().selected_tag
	-- check if any open clients
	for _ in pairs(t:clients()) do
		return
	end
	-- unblur if no open clients
	unblur()
end)
