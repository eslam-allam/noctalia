local v = require("variables")
-- ######## Tags ########

-- Xwaylandpopup tags
hl.window_rule({ match = { title = "^(wpp|wps|pdf|et)$", class = "^(wpp|wps|pdf|et)$", xwayland = true }, tag = "+xwaylandpopup" })
hl.window_rule({ match = { xwayland = true, title = "win[0-9]+" }, tag = "+xwaylandpopup" })
hl.window_rule({ match = { xwayland = true, title = "^(\\s*)$" }, tag = "+xwaylandpopup" })
hl.window_rule({ match = { xwayland = true, title = "^([Oo][Nn][Ll][Yy][Oo][Ff][Ff][Ii][Cc][Ee])$", class = "^([Oo][Nn][Ll][Yy][Oo][Ff][Ff][Ii][Cc][Ee])$", float = true }, tag = "+xwaylandpopup" })

-- Office Suite Tags
hl.window_rule({ match = { class = "^(libreoffice|libreoffice-base|libreoffice-calc|libreoffice-writer|libreoffice-impress)$" }, tag = "+office" })
hl.window_rule({ match = { class = "^([Oo][Nn][Ll][Yy][Oo][Ff][Ff][Ii][Cc][Ee])$" }, tag = "+office" })

-- Tooltip tags
hl.window_rule({ match = { class = "^(com-eteks-sweethome3d-SweetHome3D)$", title = "^(win1)$" }, tag = "+tooltip" })

-- Utility Tags
hl.window_rule({ match = { class = "^(localsend)$" }, tag = "+utility" })
hl.window_rule({ match = { class = "^(better_control\\.py)$" }, tag = "+utility" })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-.*)$" }, tag = "+utility" })
hl.window_rule({ match = { class = "^(org\\.freedesktop\\.impl\\.portal\\.desktop.*)$" }, tag = "+utility" })
hl.window_rule({ match = { class = "^(nwg-displays)$" }, tag = "+utility" })
hl.window_rule({ match = { class = "^(org\\.x\\.GnomeOnlineAccountsGtk)$" }, tag = "+utility" })
hl.window_rule({ match = { class = "^(com\\.gabm\\.satty)$" }, tag = "+utility" })
hl.window_rule({ match = { class = "^(com\\.github\\.monique)$" }, tag = "+utility" })

-- Email tags
hl.window_rule({ match = { class = "^([Tt]hunderbird|org.gnome.Evolution)$" }, tag = "+email" })
hl.window_rule({ match = { class = "^(eu.betterbird.Betterbird)$" }, tag = "+email" })
hl.window_rule({ match = { class = "^([Bb]lue[Mm]ail)$" }, tag = "+email" })

-- Picture in Picture tags
hl.window_rule({ match = { title = "Picture(-| )in(-| )[Pp]picture" }, tag = "+pip" })
hl.window_rule({ match = { initial_title = "^([Dd]iscord [Pp]opout)$" }, tag = "+pip" })

-- ######## Window rules ########
hl.window_rule({ match = { fullscreen = false }, opacity = v.windowOpacity .. " override" })

hl.window_rule({ match = { class = "foot|equibop|org\\.quickshell|imv|swappy" }, opaque = true })
hl.window_rule({ match = { float = false, xwayland = false }, center = true })

-- Utility
hl.window_rule({ match = { tag = "utility*" }, float = true, center = true, size = { "monitor_w*0.60", "monitor_h*0.70" } })

-- Float
hl.window_rule({ match = { class = "guifetch" }, float = true })
hl.window_rule({ match = { class = "yad" }, float = true })
hl.window_rule({ match = { class = "zenity" }, float = true })
hl.window_rule({ match = { class = "wev" }, float = true })
hl.window_rule({ match = { class = "org\\.gnome\\.FileRoller" }, float = true })
hl.window_rule({ match = { class = "file-roller" }, float = true })
hl.window_rule({ match = { class = "blueman-manager" }, float = true })
hl.window_rule({ match = { class = "com\\.github\\.GradienceTeam\\.Gradience" }, float = true })
hl.window_rule({ match = { class = "feh" }, float = true })
hl.window_rule({ match = { class = "imv" }, float = true })
hl.window_rule({ match = { class = "system-config-printer" }, float = true })
hl.window_rule({ match = { class = "org\\.quickshell" }, float = true })
hl.window_rule({ match = { class = "guvcview", title = "[Gg]uvcview" }, float = true })
hl.window_rule({ match = { class = "^(net\\.code-industry\\.masterpdfeditor4)$", title = "^([Aa]ction)$" }, float = true })
hl.window_rule({ match = { title = "^([bB]itwarden - Vivaldi)$", class = "^(vivaldi.*)$" }, float = true })

-- Float, resize and center
hl.window_rule({ match = { class = "foot", title = "nmtui" }, float = true, size = { "monitor_w*0.60", "monitor_h*0.70" }, center = true })
hl.window_rule({ match = { class = "org\\.gnome\\.Settings" }, float = true, size = { "monitor_w*0.70", "monitor_h*0.80" }, center = true })
hl.window_rule({ match = { class = "org\\.pulseaudio\\.pavucontrol|yad-icon-browser" }, float = true, size = { "monitor_w*0.60", "monitor_h*0.70" }, center = true })
hl.window_rule({ match = { class = "nwg-look" }, float = true, size = { "monitor_w*0.50", "monitor_h*0.60" }, center = true })

-- Special workspaces
hl.window_rule({ match = { class = "btop" }, workspace = "special:sysmon" })
hl.window_rule({ match = { class = "feishin|Spotify|Supersonic|Cider" }, workspace = "special:music" })
hl.window_rule({ match = { initial_title = "Spotify( Free)?" }, workspace = "special:music" })
hl.window_rule({ match = { class = "discord|equibop|vesktop|whatsapp|ferdium|rambox" }, workspace = "special:communication" })
hl.window_rule({ match = { class = "Todoist" }, workspace = "special:todo" })

-- Dialogs
hl.window_rule({ match = { title = "(Select|Open)( a)? (File|Folder)(s)?" }, float = true })
hl.window_rule({ match = { title = "File (Operation|Upload)( Progress)?" }, float = true })
hl.window_rule({ match = { title = ".* Properties" }, float = true })
hl.window_rule({ match = { title = "Export Image as PNG" }, float = true })
hl.window_rule({ match = { title = "GIMP Crash Debug" }, float = true })
hl.window_rule({ match = { title = "Save As" }, float = true })
hl.window_rule({ match = { title = "Library" }, float = true })
hl.window_rule({ match = { title = "Rename .*" }, float = true })

-- Picture in picture
hl.window_rule({
  match = { tag = "pip*" },
  size = { "monitor_w*0.25", "monitor_h*0.3" },
  move = { "(monitor_w-window_w-(monitor_w*0.005))", "monitor_h*0.05" },
  keep_aspect_ratio = true,
  float = true,
  pin = true
})

-- Steam
hl.window_rule({ match = { title = "", class = "steam" }, rounding = 10 })
hl.window_rule({ match = { title = "Friends List", class = "steam" }, float = true })
hl.window_rule({ match = { class = "steam_app_[0-9]+" }, immediate = true, idle_inhibit = "always", fullscreen = true, workspace = "name:gaming" })
hl.window_rule({ match = { class = "gamescope*" }, immediate = true, idle_inhibit = "always", fullscreen = true, workspace = "name:gaming" })
hl.window_rule({ match = { class = "steam" }, workspace = "name:gaming" })

-- ATLauncher console
hl.window_rule({ match = { class = "com-atlauncher-App", title = "ATLauncher Console" }, float = true })

-- Autodesk Fusion 360
hl.window_rule({ match = { title = "Fusion360|(Marking Menu)", class = "fusion360\\.exe" }, no_blur = true })
hl.window_rule({ match = { class = "^([Gg]romit-mpx)$" }, no_blur = true })

-- Xwayland popups
hl.window_rule({
  match = { tag = "xwaylandpopup*" },
  no_dim = true,
  no_shadow = true,
  rounding = 10,
  no_blur = true,
  decorate = false
})

-- Float / Persistent Size / App Rules
hl.window_rule({ match = { class = "([Zz]oom|onedriver|onedriver-launcher|[Oo]ne[Dd]rive[Gg][Uu][Ii])$" }, float = true, persistent_size = true })

hl.window_rule({
  match = { class = "^(com.nextcloud.desktopclient.nextcloud)$" },
  float = true,
  size = { "monitor_w*0.3", "monitor_h*0.7" },
  no_initial_focus = true
})

hl.window_rule({ match = { class = "(org.gnome.Calculator)", title = "(Calculator)" }, float = true })
hl.window_rule({ match = { class = "^([Qq]alculate-gtk)$" }, float = true, persistent_size = true })

hl.window_rule({ match = { class = "^([Zz]otero)$", initial_title = "negative:^([Zz]otero)$" }, float = true, suppress_event = "maximize" })
hl.window_rule({ match = { class = "^([Zz]otero)$", title = "^([Cc]itation [Dd]ialog)$" }, size = { "monitor_w*0.70", "monitor_h*0.30" } })
hl.window_rule({ match = { class = "^([Zz]otero)$", title = "^([Ee]dit [Bb]ibliography)$" }, size = { "monitor_w*0.70", "monitor_h*0.30" } })

hl.window_rule({ match = { class = "^(org.inkscape.Inkscape)$", initial_title = "negative:^(org.inkscape.Inkscape)$" }, float = true })
hl.window_rule({ match = { title = "^(Add Folder to Workspace)$" }, float = true, size = { "monitor_w*0.70", "monitor_h*0.60" }, center = true })
hl.window_rule({ match = { initial_title = "(Open Files)" }, float = true, size = { "monitor_w*0.70", "monitor_h*0.60" } })
hl.window_rule({ match = { class = "^(com.vixalien.sticky)$" }, float = true, size = { "monitor_w*0.20", "monitor_h*0.50" } })
hl.window_rule({ match = { class = "^(com.vixalien.sticky)$", title = "negative:^([Ss]ticky [Nn]otes)$" }, pin = true })

hl.window_rule({ match = { class = "^([Ee]mulator)$" }, float = true })

-- Hide
hl.window_rule({ match = { tag = "hide*" }, workspace = "special:trash silent" })

-- Emu8086
hl.window_rule({ match = { class = "^(emu8086\\.exe)$" }, tile = true })
hl.window_rule({ match = { class = "^(emu8086\\.exe)$", title = "^(welcome.*)$" }, float = true })
hl.window_rule({ match = { class = "^(emu8086\\.exe)$", title = "negative:^(emu8086 - assembler and microprocessor emulator.*)$" }, float = true })
hl.window_rule({ match = { class = "^(emu8086\\.exe)$", title = "^(emu8086)$" }, tag = "+hide" })

hl.window_rule({ match = { class = "^(com-cburch-logisim-[Mm]ain)$", title = "^(main of.*)$" }, tile = true })

-- Email
hl.window_rule({ match = { tag = "email*" }, workspace = "special:email" })

-- WPS Popups
hl.window_rule({ match = { title = "^(wpp|wps|pdf|et)$", class = "^(wpp|wps|pdf|et)$", xwayland = true }, float = true })

-- Office Suite
hl.window_rule({ match = { tag = "office*" }, maximize = true })
hl.window_rule({ match = { class = "^([Vv]sim)$" }, maximize = true })
hl.window_rule({ match = { class = "^(quartus)$", title = "^([Pp]in [Pp]lanner.*)$" }, maximize = true })

-- ######## Workspace rules ########
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = v.singleWindowGapsOut })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = v.singleWindowGapsOut })

-- ######## Layer rules ########
hl.layer_rule({ match = { namespace = "hyprpicker" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "logout_dialog" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "selection" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "wayfreeze" }, animation = "fade" })

-- Fuzzel
hl.layer_rule({ match = { namespace = "launcher" }, animation = "popin 80%", blur = true })

-- Noctalia Screenshot
hl.layer_rule({ match = { namespace = "noctalia-shell:regionSelector" }, no_anim = true })
