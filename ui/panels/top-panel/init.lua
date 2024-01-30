local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local widgets = require("ui.widgets")
local wbutton = require("ui.widgets.button")
local animation = require("modules.animation")
local apps = require("configuration.apps")


return function(s)
    --- Widgets
    --- ~~~~~~~~~~
    s.clock = require("ui.panels.top-panel.clock")(s)
    local tags = require("ui.panels.top-panel.tag")(s)
    s.brightness = require("ui.widgets.brightness-widget.brightness")(s)
    s.cpu = require("ui.widgets.cpu-widget.cpu-widget")(s)
    s.volume = require("ui.widgets.volume-widget.volume")(s)
    s.battery = require("ui.widgets.battery.init")
    --local wallpaper_blur = require("path.to.wallpaper_blur")
    --wallpaper_blur.setup()



    --- Taglist buttons

    local modkey = "Mod4"
    local taglist_buttons = gears.table.join(
        awful.button({}, 1,
            function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end
        end), awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end
        end), awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end), awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end))

    local function tag_list(s)
        local taglist = awful.widget.taglist({
            screen = s,
            filter = awful.widget.taglist.filter.all,
            layout = { layout = wibox.layout.fixed.horizontal },
            widget_template = {
                widget = wibox.container.margin,
                forced_width = dpi(40),
                forced_height = dpi(40),
                create_callback = function(self, c3, _)
                    local indicator = wibox.widget({
                        widget = wibox.container.place,
                        valign = "center",
                        {
                            widget = wibox.container.background,
                            forced_height = dpi(50),
                            shape = helpers.ui.rrect(dpi(50))
                        }
                    })

                    self.indicator_animation = animation:new({
                        duration = 0.125,
                        easing = animation.easing.linear,
                        update = function(self, pos)
                            indicator.children[1].forced_width = pos
                        end
                    })

                    self:set_widget(indicator)

                    --- Tag preview
                    self:connect_signal("mouse::enter", function()
                        if #c3:clients() > 0 then
                            awesome.emit_signal("bling::tag_preview::update", c3)
                            awesome.emit_signal(
                                "bling::tag_preview::visibility", s, true)
                        end
                    end)

                    self:connect_signal("mouse::leave", function()
                        awesome.emit_signal("bling::tag_preview::visibility", s,
                            false)
                    end)
                end,
                update_callback = function(self, c3, _)
                    if c3.selected then
                        self.widget.children[1].bg = beautiful.accent
                        self.indicator_animation:set(dpi(32))
                    elseif #c3:clients() == 0 then
                        self.widget.children[1].bg = beautiful.color10
                        self.indicator_animation:set(dpi(8))
                    else
                        self.widget.children[1].bg = beautiful.color11
                        self.indicator_animation:set(dpi(16))
                    end
                end
            },
            buttons = taglist_buttons
        })

        local widget = widgets.button.elevated.state({
            normal_bg = beautiful.transparent,
            normal_shape = helpers.ui.rrect(dpi(50)),
            child = {
                taglist,
                margins = { left = dpi(5), right = dpi(5) },
                widget = wibox.container.margin
            }
            -- on_release = function()
            -- awesome.emit_signal("central_panel::toggle", s)
            -- end,
        })

        return wibox.widget({
            widget,
            margins = dpi(5),
            widget = wibox.container.margin
        })
    end


    -- terminal
    local function terminal()
        local term_icon = wibox.widget({
            markup = helpers.ui.colorize_text("󰆍", beautiful.color2),
            align = "center",
            valign = "center",
            font = beautiful.material_icons .. " 14",
            widget = wibox.widget.textbox
        })

        local widget = wbutton.elevated.state({
            child = term_icon,
            normal_shape = gears.shape.circle,
            hover_shape = gears.shape.circle,
            press_shape = gears.shape.circle,
            normal_bg = beautiful.transparent,
            on_release = function()
                awful.spawn(apps.default.terminal, false)
            end
        })

        return widget
    end

    -- neovim
    local function nvim()
        local vim_icon = wibox.widget({
            markup = helpers.ui.colorize_text("", beautiful.fg_normal),
            align = "center",
            valign = "center",
            font = beautiful.ios .. " 14",
            widget = wibox.widget.textbox
        })

        local widget = wbutton.elevated.state({
            child = vim_icon,
            normal_shape = gears.shape.circle,
            hover_shape = gears.shape.circle,
            press_shape = gears.shape.circle,
            normal_bg = beautiful.transparent,
            on_release = function()
                awful.spawn(apps.default.text_editor, false)
            end
        })

        return widget
    end



    -- vscode
    local function code()
        local code_icon = wibox.widget({
            markup = helpers.ui.colorize_text("󰘐", beautiful.color4),
            align = "center",
            valign = "center",
            font = beautiful.material_icons .. " 14",
            widget = wibox.widget.textbox
        })

        local widget = wbutton.elevated.state({
            child = code_icon,
            normal_shape = gears.shape.circle,
            hover_shape = gears.shape.circle,
            press_shape = gears.shape.circle,
            normal_bg = beautiful.transparent,
            on_release = function()
                awful.spawn(apps.default.code_editor, false)
            end
        })

        return widget
    end

    --- Layoutbox
    --- ~~~~~~~~~
    local function layoutbox()
        local layoutbox_buttons = gears.table.join(
        --- Left click
            awful.button({}, 1, function(c) awful.layout.inc(1) end),
            --- Scrolling
            awful.button({}, 4, function() awful.layout.inc(-1) end),
            awful.button({}, 5, function() awful.layout.inc(1) end))

        s.mylayoutbox = awful.widget.layoutbox()
        s.mylayoutbox:buttons(layoutbox_buttons)

        local widget = wbutton.elevated.state({
            child = s.mylayoutbox,
            normal_shape = gears.shape.circle,
            hover_shape = gears.shape.circle,
            press_shape = gears.shape.circle,
            normal_bg = beautiful.transparent
        })

        return widget
    end

    --- Create the top_panel
    --- ~~~~~~~~~~~~~~~~~~~~~~~
    s.top_panel = awful.popup({
        screen = s,
        type = "dock",
        shape = helpers.ui.rrect(beautiful.rounded * 4),
        maximum_height = beautiful.wibar_height,
        -- minimum_width = s.geometry.width,
        minimum_width = s.geometry.width - beautiful.useless_gap * 12,
        -- maximum_width = s.geometry.width,
        placement = function()
            awful.placement.top(s.top_panel,
                { margins = beautiful.useless_gap })
        end,
        bg = beautiful.transparent,
        widget =
        {
            {
                layout = wibox.layout.align.horizontal,
                {
                    {
                        {
                            -- left
                            terminal(),
                            nvim(),
                            code(),
                            -- spacing = dpi(1),
                            layout = wibox.layout.fixed.horizontal
                        },
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                nil,
                {
                    {
                        -- right
                        wibox.widget.systray(),
                        awful.widget.keyboardlayout(),
                        s.brightness,
                        s.volume,
                        s.cpu,
                        s.battery,
                        s.clock,
                        layoutbox(),
                        -- spacing = 0.5,
                        layout = wibox.layout.fixed.horizontal
                    },
                    layout = wibox.layout.fixed.horizontal
                }
            },
            {
                {
                    {
                        {
                            { tags, layout = wibox.layout.fixed.horizontal },
                            left = 10,
                            right = 10,
                            widget = wibox.container.margin
                        },
                        shape = helpers.ui.rrect(dpi(50)),
                        widget = wibox.container.background,
                        bg = beautiful.transparent
                    },
                    top = 2,
                    buttom = 2,
                    left = 20,
                    right = 20,
                    widget = wibox.container.margin
                },
                halign = "center",
                widget = wibox.widget.margin,
                layout = wibox.container.place
            },
            layout = wibox.layout.stack
        }
    })

    s.top_panel:struts({
        top = s.top_panel.maximum_height + beautiful.useless_gap * 3
    })

    --- Remove top_panel on full screen
    local function remove_top_panel(c)
        if c.fullscreen or c.maximized then
            c.screen.top_panel.visible = false
        else
            c.screen.top_panel.visible = true
        end
    end

    --- Return top_panel on full screen
    local function add_top_panel(c)
        if c.fullscreen or c.maximized then
            c.screen.top_panel.visible = true
        end
    end

    --- Hide bar when a splash widget is visible
    awesome.connect_signal("widgets::splash::visibility", function(vis)
        screen.primary.top_panel.visible = not vis
    end)

    client.connect_signal("property::fullscreen", remove_top_panel)
    client.connect_signal("request::unmanage", add_top_panel)
end
