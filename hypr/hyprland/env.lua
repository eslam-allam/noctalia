local v = require("variables")

-- ############# Themes #############
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", 1)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)
hl.env("XCURSOR_THEME", v.cursorTheme)
hl.env("XCURSOR_SIZE", v.cursorSize)

-- ######## Toolkit backends ########
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11,windows")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- ####### XDG specifications #######
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- ############# Others #############
hl.env("_JAVA_AWT_WM_NONREPARENTING", 1)

hl.env("EMAIL_CLIENT", "thunderbird")
hl.env("EMAIL_CLIENT_CLASS", "thunderbird")

-- ########### Gaming ################
hl.env("PROTON_USE_NTSYNC", 1)

hl.env("APP2UNIT_SLICES", "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice")
