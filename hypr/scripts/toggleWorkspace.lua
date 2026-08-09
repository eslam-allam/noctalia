local M = {}

--- Helper to check if a class exists among currently open clients
local function is_client_open(target_class)
	local clients = hl.get_windows()
	if not clients then
		return false
	end

	for _, client in ipairs(clients) do
		if client.class == target_class then
			return true
		end
	end
	return false
end

--- Helper to check if the special workspace is currently active on any monitor
local function is_special_active(workspace_name)
	local monitors = hl.get_monitors()
	if not monitors then
		return false
	end

	local target_special = "special:" .. workspace_name
	for _, mon in ipairs(monitors) do
		if mon.active_special_workspace and mon.active_special_workspace.name == target_special then
			return true
		end
	end
	return false
end

--- Toggles a special workspace and launches or moves specified applications
--- @param workspace_name string Name of the special workspace (e.g. "sysmon", "music")
--- @param apps table? List of app strings e.g. { "btop:btop", "flatpak:com.spotify.Client:Spotify" }
function M.toggle(workspace_name, apps)
	if not workspace_name or workspace_name == "" then
		return function() end
	end

	apps = apps or {}

	-- If special workspace is currently open on a monitor, toggle it closed and exit
	if is_special_active(workspace_name) then
		return function()
			hl.dispatch(hl.dsp.workspace.toggle_special(workspace_name))
		end
	end

	return function()
		-- Toggle special workspace open
		hl.dispatch(hl.dsp.workspace.toggle_special(workspace_name))

		-- Process each app definition
		for _, pair in ipairs(apps) do
			local pieces = {}
			for part in string.gmatch(pair, "[^:]+") do
				table.insert(pieces, part)
			end

			local command = ""
			local class = ""

			if #pieces == 2 then
				command = "app2unit -- " .. pieces[1]
				class = pieces[2]
			elseif #pieces == 3 then
				local modifier = pieces[1]
				if modifier == "flatpak" then
					command = "flatpak run " .. pieces[2]
					class = pieces[3]
				end
			end

			if class == "" then
				return
			end

			if not is_client_open(class) then
				if command ~= "" then
					-- Launch missing app with rules to force it onto the target special workspace
					return hl.exec_cmd(command, {
						workspace = "special:" .. workspace_name,
					})
				end
			else
				-- Client is open, move it to the special workspace
				return hl.dispatch(hl.dsp.window.move({
					workspace = "special:" .. workspace_name,
					window = "class:^(" .. class .. ")$",
				}))
			end
		end
	end
end

return M
