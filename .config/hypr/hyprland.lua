-- Hyprland Lua Config
-- Migrated from hyprland.conf

local colors = require("themes/mocha")

--------------------
---- VARIABLES ----
--------------------

local scale       = 1.6
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "wofi --conf ~/.config/wofi/config --style ~/.config/wofi/src/mocha/style.css"

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "",      mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = scale })

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/waybar/launch_waybar.sh & nm-applet --indicator & dunst & hyprpaper & kanshi & hypridle")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 2,
        border_size = 2,

        col = {
            active_border   = "rgba(268bd2ee)",
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    xwayland = {
        force_zero_scaling = true,
    },

    decoration = {
        rounding         = 5,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        force_split = 2,
    },

    master = {
        new_status = "master",
    },

    input = {
        kb_layout  = "us",
        kb_variant = "altgr-intl",
        kb_model   = "",
        kb_options = "ctrl:nocaps",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

------------------
---- CURVES ----
------------------

hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

---------------------
---- ANIMATIONS ----
---------------------

hl.animation({ leaf = "windows",     enabled = true,  speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true,  speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true,  speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true,  speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true,  speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = false, speed = 6,  bezier = "default" })

---------------
---- INPUT ----
---------------

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN",   hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",        hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + M",        hl.dsp.exit())
hl.bind(mainMod .. " + E",        hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",        hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",        hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F",        hl.dsp.window.fullscreen({ fullscreen, toggle }))

-- Move focus with vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize active window
-- hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = 20, y = 0 })) -- TODO()
-- hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ exact = "20 0" }))
-- hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ exact = "0 -20" }))
-- hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ exact = "0 20" }))

-- Media controls
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("playerctl play-pause"))

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pamixer --default-source --toggle-mute"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pamixer -t"))

-- Screen brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"))

-- Screenshots
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + P",     hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Open apps
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("firefox"))
