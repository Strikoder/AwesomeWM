local awful = require("awful")
local bling = require("modules.bling")


--- Custom Layouts
local mstab = bling.layout.mstab

--- Set the layouts
tag.connect_signal(
    "request::default_layouts",
    function()
        awful.layout.append_default_layouts(
            {
                awful.layout.suit.tile,
                mstab,
            }
        )
    end
)
