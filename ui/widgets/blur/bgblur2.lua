-- ===================================================================
-- Wallpaper Blurring Script
-- This script is similar to the previous one. However the previous one is faster in tag switching but slower in bluring.
-- ===================================================================

-- Imports
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local config_dir = gears.filesystem.get_configuration_dir()

-- Initialization
local blurred = false
local wallpaper = config_dir .. "/wallpaper/bg1.jpg"
local blurredWallpaper = config_dir .. "/blurredWallpaper.png"

-- Load the wallpapers
local regular_wallpaper_surface = gears.surface(wallpaper)
local blurred_wallpaper_surface = gears.surface(blurredWallpaper)

-- Check if a file exists
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

-- Create blurred wallpaper if it doesn't exist
if not exists(blurredWallpaper) then
    naughty.notify({
        preset = naughty.config.presets.normal,
        title = 'Wallpaper',
        text = 'Generating blurred wallpaper...'
    })
    awful.spawn.with_shell("convert -filter Gaussian -blur 0x8 " .. wallpaper .. " " .. blurredWallpaper)
end

-- Function to apply wallpaper based on state
local function apply_wallpaper()
    if blurred then
        gears.wallpaper.maximized(blurred_wallpaper_surface, awful.screen.focused(), false)
    else
        gears.wallpaper.maximized(regular_wallpaper_surface, awful.screen.focused(), true)
    end
end

-- Tag change signal
tag.connect_signal('property::selected', function(t)
    blurred = #t:clients() > 0
    apply_wallpaper()
end)
-- Client manage/unmanage signals
client.connect_signal("manage", function(c)
    if c.first_tag then
        blurred = true
        apply_wallpaper()
    end
end)

client.connect_signal("unmanage", function(c)
    local t = awful.screen.focused().selected_tag
    if t and #t:clients() == 0 then
        blurred = false
        apply_wallpaper()
    end
end)
