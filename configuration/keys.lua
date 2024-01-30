local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local naughty = require("naughty")
local helpers = require("helpers")
local apps = require("configuration.apps")
local menubar = require("menubar")

--- Make key easier to call
--- ~~~~~~~~~~~~~~~~~~~~~~~
mod = "Mod4"
alt = "Mod1"
ctrl = "Control"
shift = "Shift"

--- Global key bindings
--- ~~~~~~~~~~~~~~~~~~~
awful.keyboard.append_global_keybindings({

	--- App
	--- ~~~
	-- Terminal
	awful.key({ mod }, "Return", function()
		awful.spawn(apps.default.terminal)
	end, { description = "open terminal", group = "app" }),

	--- App launcher
	awful.key({ mod }, "d", function()
		awful.spawn.with_shell(apps.default.launcher)
	end, { description = "open app launcher", group = "app" }),

	--- Code editor
	awful.key({ mod, shift }, "e", function()
		awful.spawn(apps.default.code_editor)
	end, { description = "open code editor", group = "app" }),

	--- File manager
	awful.key({ mod, shift }, "f", function()
		awful.spawn(apps.default.file_manager)
	end, { description = "open file manager", group = "app" }),

	--- Web browser
	awful.key({ mod, shift }, "w", function()
		awful.spawn(apps.default.web_browser)
	end, { description = "open web browser", group = "app" }),

	--- WM
	--- ~~
	--- Restart awesome
	awful.key({ mod, ctrl }, "r", awesome.restart, { description = "reload awesome", group = "WM" }),

	--- Quit awesome
	awful.key({ mod, shift }, "q", awesome.quit, { description = "quit awesome", group = "WM" }),

	--- Show help
	awful.key({ mod }, "F1", hotkeys_popup.show_help, { description = "show Help", group = "WM" }),


	--- Menubar
	awful.key({ mod }, "p", function() menubar.show() end,
		{ description = "show the menubar", group = "launcher" }),


	--- Screenshots
	awful.key({ mod }, "Print", function() take_screenshot_with_timer(5) end,
		{ description = "Take screenshot with timer", group = "Screenshots" }),
	awful.key({}, "Print", function() take_fullscreen_screenshot() end,
		{ description = "Take fullscreen screenshot", group = "Screenshots" }),
	awful.key({ alt }, "Print", function() take_selected_area_screenshot() end,
		{ description = "Take selected area screenshot", group = "Screenshots" }),

	--- Lockscreen
	awful.key({ mod, alt }, "l", function()
		lock_screen_show()
	end, { description = "lock screen", group = "hotkeys" }),

	--- Exit screen
	awful.key({ mod }, "Escape", function()
		awesome.emit_signal("module::exit_screen:show")
	end, { description = "exit screen", group = "hotkeys" }),
})

--- Client key bindings
--- ~~~~~~~~~~~~~~~~~~~
client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({

		awful.key({ mod, }, "o", function(c) c:move_to_screen() end),

		-- screenshot
		--awful.key({ mod }, ";", function() brightness_widget:inc() end,
		--	{ description = "increase brightness", group = "amin" }),
		--awful.key({ mod, "Shift" }, ";", function() brightness_widget:dec() end,
		--		{ description = "decrease brightness", group = "amin" }),
		--

		awful.key({ mod }, "j", function() awful.client.focus.byidx(1) end,
			{ description = "focus next by index", group = "client" }),
		awful.key({ mod }, "k", function() awful.client.focus.byidx(-1) end,
			{ description = "focus previous by index", group = "client" }),

		-- Layout manipulation
		awful.key({ mod, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
			{ description = "swap with next client by index", group = "client" }),
		awful.key({ mod, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
			{ description = "swap with previous client by index", group = "client" }),


		awful.key({ mod, "Control" }, "j", function() awful.screen.focus_relative(1) end,
			{ description = "focus the next screen", group = "screen" }),
		awful.key({ mod, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
			{ description = "focus the previous screen", group = "screen" }),


		awful.key({ mod, }, "Tab",
			function()
				awful.client.focus.history.previous()
				if client.focus then
					client.focus:raise()
				end
			end,
			{ description = "go back", group = "client" }),

		awful.key({ mod, }, "l", function() awful.tag.incmwfact(0.05) end,
			{ description = "increase master width factor", group = "layout" }),
		awful.key({ mod, }, "h", function() awful.tag.incmwfact(-0.05) end,
			{ description = "decrease master width factor", group = "layout" }),
		awful.key({ mod, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
			{ description = "increase the number of master clients", group = "layout" }),
		awful.key({ mod, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
			{ description = "decrease the number of master clients", group = "layout" }),
		awful.key({ mod, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
			{ description = "increase the number of columns", group = "layout" }),
		awful.key({ mod, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
			{ description = "decrease the number of columns", group = "layout" }),
		awful.key({ mod, }, "space", function() awful.layout.inc(1) end,
			{ description = "select next", group = "layout" }),
		awful.key({ mod, "Shift" }, "space", function() awful.layout.inc(-1) end,
			{ description = "select previous", group = "layout" }),




		--- Toggle fullscreen
		awful.key({ mod }, "f", function()
			client.focus.fullscreen = not client.focus.fullscreen
			client.focus:raise()
		end),

		--- Maximize windows
		awful.key({ mod }, "m", function(c)
			c.maximized = not c.maximized
		end, { description = "toggle maximize", group = "client" }),

		awful.key({ mod }, "n", function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end, { description = "minimize", group = "client" }),

		--- Un-minimize windows
		awful.key({ mod, ctrl }, "n", function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:activate({ raise = true, context = "key.unminimize" })
			end
		end, { description = "restore minimized", group = "client" }),

		--- Close window
		awful.key({ mod }, "w", function()
			client.focus:kill()
		end),


	})
end)

--- Layout
--- ~~~~~~
awful.keyboard.append_global_keybindings({
	--- On the fly useless gaps change
	awful.key({ mod }, "=", function()
		helpers.client.resize_gaps(5)
	end, { description = "add gaps", group = "layout" }),

	awful.key({ mod }, "-", function()
		helpers.client.resize_gaps(-5)
	end, { description = "subtract gaps", group = "layout" }),
})

--- Move through workspaces
--- ~~~~~~~~~~~~~~~~~~~~~~~
awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { mod },
		keygroup = "numrow",
		description = "only view tag",
		group = "tags",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),
	awful.key({
		modifiers = { mod, ctrl },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tags",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),
	awful.key({
		modifiers = { mod, shift },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tags",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
})

-- Screen
-----------
--awful.keyboard.append_global_keybindings({
-- No need for these (single screen setup)
--awful.key({ superkey, ctrlkey }, "j", function () awful.screen.focus_relative( 1) end,
--{description = "focus the next screen", group = "screen"}),
--awful.key({ superkey, ctrlkey }, "k", function () awful.screen.focus_relative(-1) end,
--{description = "focus the previous screen", group = "screen"}),
--})
--- Mouse buttons on the client
--- ~~~~~~~~~~~~~~~~~~~~~~~~~~~
client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:activate({ context = "mouse_click" })
		end),
		awful.button({ mod }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_move" })
		end),
		awful.button({ mod }, 3, function(c)
			c:activate({ context = "mouse_click", action = "mouse_resize" })
		end),
	})
end)
