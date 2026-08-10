hl.on("hyprland.start", function()
	local v = require("variables")

	-- Keyring and auth
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

	-- Clipboard history
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	-- Auto delete trash 30 days old
	hl.exec_cmd("trash-empty 30")

	-- Cursors
	hl.exec_cmd("hyprctl setcursor " .. v.cursorTheme .. " " .. v.cursorSize)
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme '" .. v.cursorTheme .. "'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. v.cursorSize)

	-- Location provider and night light
	hl.exec_cmd("/usr/lib/geoclue-2.0/demos/agent")
	hl.exec_cmd("sleep 1 && gammastep")

	-- Forward bluetooth media commands to MPRIS
	hl.exec_cmd("mpris-proxy")

	-- Start shell
	hl.exec_cmd("noctalia")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("systemctl --user start hypridle.service")

	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("hyprpm reload")
end)
