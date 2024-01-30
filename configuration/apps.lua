local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"

return {
    --- Default Applications
    default = {
        --- Default terminal emulator
        terminal = "gnome-terminal",
        --- Default text editor
        text_editor = "nvim",
        --- Default code editor
        code_editor = "code",
        --- Default network manager
        --network_manager = "nm-applet",
        --- Default launcher
        launcher = utils_dir .. "/launcher/launcher.sh",

    },

    --- List of binaries/shell scripts that will execute for a certain task
    utils = {
        --- Fullscreen screenshot
        full_screenshot = utils_dir .. "ss.sh -f",
        --- Area screenshot
        area_screenshot = utils_dir .. "ss.sh -s",
        ---10 second
        time_screenshot = utils_dir .. "ss.sh -t 10",
        --- Color Picker
        color_picker = utils_dir .. "colorpicker"
    }
}


