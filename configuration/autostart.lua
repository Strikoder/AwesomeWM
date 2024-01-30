local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local helpers = require("helpers")

local function autostart_apps()
    --- Compositor
    helpers.run.check_if_running("picom", nil, function()
        awful.spawn("picom --config " .. config_dir ..
            "configuration/picom.conf -b", false)
    end)

    --- xrdb
    helpers.run.run_once_pgrep("xrdb merge $HOME/.Xresources")
    --- Polkit Agent
    helpers.run.run_once_pgrep(
        "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1")
    -- cursor speed
    helpers.run.run_once_pgrep("xset r rate 200 50")
    -- Wifi
    helpers.run.run_once_grep("nm-applet")

    -- Add keyboard layouts
    awful.spawn("setxkbmap -layout us,ru,ar -option 'grp:alt_shift_toggle'")

    -- Prevent from sleeping
    awful.spawn("xset s off")
    awful.spawn("xset -dpms")
    awful.spawn("xset s noblank")

    -- 2 monitor
    awful.spawn.with_shell("xrandr --output HDMI-0 --rotate right; sleep 1")

    awful.spawn.with_shell("gnome-terminal -- zsh -c 'neofetch; exec bash'", { tag = thrid_tag })
    awful.spawn.with_shell("gnome-terminal -- zsh -c 'cmatrix; exec bash'", { tag = thrid_tag })
    awful.spawn.with_shell("gnome-terminal -- zsh -c 'htop; exec bash'", { tag = thrid_tag })
end

autostart_apps()
