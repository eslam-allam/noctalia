hl.on("hyprland.start", function()
	local v = require("variables")

	-- Keyring and auth
	hl.dsp.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	hl.dsp.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

	-- Clipboard history
	hl.dsp.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.dsp.exec_cmd("wl-paste --type image --watch cliphist store")

	-- Auto delete trash 30 days old
	hl.dsp.exec_cmd("trash-empty 30")

	-- Cursors
	hl.dsp.exec_cmd("hyprctl setcursor " .. v.cursorTheme .. " " .. v.cursorSize)
	hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme '" .. v.cursorTheme .. "'")
	hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. v.cursorSize)

	-- Location provider and night light
	hl.dsp.exec_cmd("/usr/lib/geoclue-2.0/demos/agent")
	hl.dsp.exec_cmd("sleep 1 && gammastep")

	-- Forward bluetooth media commands to MPRIS
	hl.dsp.exec_cmd("mpris-proxy")

	-- Start shell
	hl.dsp.exec_cmd("qs -c noctalia-shell")
	hl.dsp.exec_cmd("blueman-applet")
	hl.dsp.exec_cmd("systemctl --user start hypridle.service")

	hl.dsp.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.dsp.exec_cmd("hyprpm reload")
end)
