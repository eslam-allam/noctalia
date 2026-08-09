local function safeReq(module)
  local ok, val = pcall(require, module)
  if ok then
    print("Module " .. module .. " loaded")
    return val
  end
  print("Module " .. module .. " failed to load")
  return nil
end

local hypr = os.getenv("HOME") .. "/.config/hypr"

-- Variables (colours + other vars)
hl.dsp.exec_cmd("cp -L --no-preserve=mode --update=none " .. hypr .. "/scheme/default.conf " .. hypr .. "/scheme/current.conf")

safeReq("scheme.current")

-- Configs
safeReq("hyprland.env")
safeReq("hyprland.general")
safeReq("hyprland.input")
safeReq("hyprland.misc")
safeReq("hyprland.animations")
safeReq("hyprland.decoration")
safeReq("hyprland.group")
safeReq("hyprland.execs")
safeReq("hyprland.rules")
safeReq("hyprland.gestures")
safeReq("hyprland.keybinds")
require("monitors")
safeReq("workspaces")

-- For Noctalia Color templates
require("noctalia").apply_theme()
