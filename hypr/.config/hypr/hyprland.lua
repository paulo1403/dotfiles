hl.env("NVD_BACKEND", "direct")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GSK_RENDERER", "vulkan")
hl.env("WLR_RENDERER", "vulkan")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("GTK_THEME", "Orchis-Dark")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("ELECTRON_FORCE_DARK_MODE", "1")
hl.env("COLORFGBG", "15;0")
hl.env("XCURSOR_SIZE", "24")
hl.env("GDK_SCALE", "1")

hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@164.84",
    position = "0x0",
    scale    = 1,
})
hl.monitor({
    output   = "DP-2",
    mode     = "2560x1440@165",
    position = "2560x0",
    scale    = 1,
})

hl.config({
    general = {
    gaps_in    = 5,
    gaps_out   = 10,
    border_size = 2,
    col = {
        active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
        inactive_border = "rgba(595959aa)",
    },
    },
})

hl.config({
    decoration = {
        rounding       = 0,
        rounding_power = 2,
        dim_inactive   = false,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        blur = {
            enabled           = false,
        },
        shadow = {
            enabled          = false,
        },
    },
})

hl.config({
    misc = {
        vrr                        = 2,
        disable_hyprland_logo      = true,
        force_default_wallpaper    = 0,
        animate_mouse_windowdragging = false,
        enable_swallow             = true,
        swallow_regex              = "^(kitty|alacritty|foot|ghostty)$",
    },
})

hl.config({ cursor = { no_hardware_cursors = true, hide_on_key_press = true } })
hl.config({ animations = { enabled = true } })

hl.config({
    dwindle = { preserve_split = true, force_split = 2 },
    -- evita ventana única gigante en 2560x1440 (default omarchy)
    layout = { single_window_aspect_ratio = { 1, 1 } },
})

hl.curve("easeOutQuint",  { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic",{ type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",        { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear",  { type = "bezier", points = { {0.5, 0.5}, {0.75, 1.0} } })
hl.curve("quick",         { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 3.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeSwitch",    enabled = false })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = false })

local mainMod = "SUPER"

-- Mouse: move/resize with SUPER+drag
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("wayle wallpaper next && notify-send -t 4000 'Wallpaper' 'Cambiado'"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("hyprctl killactive"))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.window.float())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ fullscreen = 1 }))

-- Focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces 1-10 (focus + move)
for i = 1, 10 do
    local key = i == 10 and "0" or tostring(i)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + ALT + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Applications
hl.bind(mainMod .. " + Return",       hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("firefox-developer-edition"))
hl.bind(mainMod .. " + SHIFT + B",    hl.dsp.exec_cmd("firefox-developer-edition"))
hl.bind(mainMod .. " + SHIFT + N",    hl.dsp.exec_cmd("nvim"))
hl.bind(mainMod .. " + E",            hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + SHIFT + F",    hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + SHIFT + V",    hl.dsp.exec_cmd("vpnwork"))
hl.bind(mainMod .. " + SHIFT + S",    hl.dsp.exec_cmd("hyprshot -m region --freeze"))

-- Menus / utilities
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("pkill -SIGUSR1 hyprexpose"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd("~/.local/bin/theme-picker"))
-- Media keys (bindel = locked + repeating)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wayle audio output-volume +1"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wayle audio output-volume -1"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wayle audio output-mute"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("~/.local/bin/osd.sh brightness up"),  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("~/.local/bin/osd.sh brightness down"),{ locked = true, repeating = true })
hl.bind("XF86AudioNext",   hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPause",  hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay",   hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev",   hl.dsp.exec_cmd("playerctl previous"))

-- Zoom
hl.bind(mainMod .. " + CTRL + Z", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.int + 0.5')"))
hl.bind(mainMod .. " + CTRL + ALT + Z", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1.0"))

-- Lock / exit
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + M", hl.dsp.exit())

-- Game mode toggle
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("~/.config/hypr/gamemode.sh"))

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprpicker -a"))

-- Workspace rules (per-monitor workspace assignment)
hl.workspace_rule({ workspace = "1", monitor = "DP-2" })
hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
hl.workspace_rule({ workspace = "4", monitor = "DP-2" })
hl.workspace_rule({ workspace = "5", monitor = "DP-2" })
hl.workspace_rule({ workspace = "6", monitor = "DP-2" })
hl.workspace_rule({ workspace = "7", monitor = "DP-1" })
hl.workspace_rule({ workspace = "8", monitor = "DP-1" })
hl.workspace_rule({ workspace = "9", monitor = "DP-1" })
hl.workspace_rule({ workspace = "10", monitor = "DP-1" })

-- Window rules
hl.window_rule({
    name  = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({ name = "float-pavu",     match = { class = "org.pulseaudio.pavucontrol" }, float = true, size = "{800, 500}", center = true })
hl.window_rule({ name = "float-blueman",  match = { class = "blueman-manager" },            float = true, size = "700 500", center = true })
hl.window_rule({ name = "float-nm",       match = { class = "nm-connection-editor" },        float = true, center = true })
hl.window_rule({ name = "float-polkit1",  match = { class = "polkit-gnome-authentication-agent-1" }, float = true, stay_focused = true, center = true })
hl.window_rule({ name = "float-polkit2",  match = { class = "org.kde.polkit-kde-authentication-agent-1" }, float = true, stay_focused = true, center = true })
hl.window_rule({ name = "float-openfile", match = { title = "Open File" },                   float = true, center = true })
hl.window_rule({ name = "float-openfolder", match = { title = "Open Folder" },               float = true, center = true })
hl.window_rule({ name = "float-savefile", match = { title = "Save File" },                   float = true, center = true })
hl.window_rule({ name = "float-calc",     match = { class = "org.gnome.Calculator" },        float = true, center = true })
hl.window_rule({ name = "float-calendar", match = { class = "org.gnome.Calendar" },          float = true, center = true })
hl.window_rule({ name = "float-pinentry", match = { class = "pinentry-*" },                  float = true, stay_focused = true, center = true })
hl.window_rule({ name = "nofull-blur",    match = { fullscreen = true },                      no_blur = true, no_dim = true })
hl.window_rule({ name = "flowfi",         match = { class = "chrome-www.flowfi.app__-Default" }, float = true, center = true, size = "1280 720", workspace = "5" })
hl.window_rule({ name = "hl2-mouse",      match = { class = "hl2_linux" },                       stay_focused = true })

hl.config({ input = { follow_mouse = 1, mouse_refocus = false, accel_profile = "flat" } })

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet --indicator")
    -- waybar: servicio systemd --user (waybar.service, WantedBy=graphical-session.target)
    hl.exec_cmd("wayle wallpaper cycle")
    hl.exec_cmd("hyprexpose")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("~/.local/bin/rgb-catppuccin 8bd5ca &")
end)

-- ponytail: tema estatico tokyo-night; matugen removido (pisaba borde omarchy)
