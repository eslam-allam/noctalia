local v = require("variables")
local wsaction = require("scripts.wsaction")
local toggleWorkspace = require("scripts.toggleWorkspace")


hl.define_submap("global", function()
  -- ## Shell keybinds
  -- Launcher
  hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call launcher toggle"), { release = true })

  -- Misc
  hl.bind(v.kbSession, hl.dsp.exec_cmd("qs -c noctalia-shell ipc call sessionMenu toggle"))
  hl.bind(v.kbClearNotifs, hl.dsp.exec_cmd("qs -c noctalia-shell ipc call notifications dismissAll"), { locked = true })
  hl.bind(v.kbShowPanels, hl.dsp.exec_cmd("qs -c noctalia-shell ipc call settings toggle"))
  hl.bind(v.kbLock, hl.dsp.exec_cmd("qs -c noctalia-shell ipc call lockScreen lock"))

  -- Media
  hl.bind("CTRL + SUPER + Space", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media playPause"), { locked = true })
  hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media playPause"), { locked = true })
  hl.bind("XF86AudioPause", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media playPause"), { locked = true })
  hl.bind("CTRL + SUPER + Equal", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media next"), { locked = true })
  hl.bind("XF86AudioNext", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media next"), { locked = true })
  hl.bind("CTRL + SUPER + Minus", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media previous"), { locked = true })
  hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media previous"), { locked = true })
  hl.bind("XF86AudioStop", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media pause"), { locked = true })

  -- Kill/restart
  hl.bind("CTRL + SUPER + SHIFT + R", hl.dsp.exec_cmd("qs -c noctalia-shell kill"), { release = true })
  hl.bind("CTRL + SUPER + ALT + R", hl.dsp.exec_cmd("qs -c noctalia-shell kill; qs -c noctalia-shell"), { release = true })

  -- Go to workspace #
  hl.bind(v.kbGoToWs .. " + 1", wsaction.action('focus', 1))
  hl.bind(v.kbGoToWs .. " + 2", wsaction.action('focus', 2))
  hl.bind(v.kbGoToWs .. " + 3", wsaction.action('focus', 3))
  hl.bind(v.kbGoToWs .. " + 4", wsaction.action('focus', 4))
  hl.bind(v.kbGoToWs .. " + 5", wsaction.action('focus', 5))
  hl.bind(v.kbGoToWs .. " + 6", wsaction.action('focus', 6))
  hl.bind(v.kbGoToWs .. " + 7", wsaction.action('focus', 7))
  hl.bind(v.kbGoToWs .. " + 8", wsaction.action('focus', 8))
  hl.bind(v.kbGoToWs .. " + 9", wsaction.action('focus', 9))
  hl.bind(v.kbGoToWs .. " + 0", wsaction.action('focus', 10))

  -- Go to workspace group #
  hl.bind(v.kbGoToWsGroup .. " + 1", wsaction.action('focus', 1, true))
  hl.bind(v.kbGoToWsGroup .. " + 2", wsaction.action('focus', 2, true))
  hl.bind(v.kbGoToWsGroup .. " + 3", wsaction.action('focus', 3, true))
  hl.bind(v.kbGoToWsGroup .. " + 4", wsaction.action('focus', 4, true))
  hl.bind(v.kbGoToWsGroup .. " + 5", wsaction.action('focus', 5, true))
  hl.bind(v.kbGoToWsGroup .. " + 6", wsaction.action('focus', 6, true))
  hl.bind(v.kbGoToWsGroup .. " + 7", wsaction.action('focus', 7, true))
  hl.bind(v.kbGoToWsGroup .. " + 8", wsaction.action('focus', 8, true))
  hl.bind(v.kbGoToWsGroup .. " + 9", wsaction.action('focus', 9, true))
  hl.bind(v.kbGoToWsGroup .. " + 0", wsaction.action('focus', 10, true))

  -- Go to workspace -1/+1
  hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "-1" }))
  hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "+1" }))
  hl.bind(v.kbPrevWs, hl.dsp.focus({ workspace = "-1" }), { repeating = true })
  hl.bind(v.kbNextWs, hl.dsp.focus({ workspace = "+1" }), { repeating = true })
  hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "-1" }), { repeating = true })
  hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "+1" }), { repeating = true })

  -- Go to workspace group -1/+1
  hl.bind("CTRL + SUPER + mouse_down", hl.dsp.focus({ workspace = "-10" }))
  hl.bind("CTRL + SUPER + mouse_up", hl.dsp.focus({ workspace = "+10" }))

  -- Toggle special workspace
  hl.bind(v.kbToggleSpecialWs, toggleWorkspace.toggle("special"))

  -- Move window to workspace #
  hl.bind(v.kbMoveWinToWs .. " + 1", wsaction.action('move', 1))
  hl.bind(v.kbMoveWinToWs .. " + 2", wsaction.action('move', 2))
  hl.bind(v.kbMoveWinToWs .. " + 3", wsaction.action('move', 3))
  hl.bind(v.kbMoveWinToWs .. " + 4", wsaction.action('move', 4))
  hl.bind(v.kbMoveWinToWs .. " + 5", wsaction.action('move', 5))
  hl.bind(v.kbMoveWinToWs .. " + 6", wsaction.action('move', 6))
  hl.bind(v.kbMoveWinToWs .. " + 7", wsaction.action('move', 7))
  hl.bind(v.kbMoveWinToWs .. " + 8", wsaction.action('move', 8))
  hl.bind(v.kbMoveWinToWs .. " + 9", wsaction.action('move', 9))
  hl.bind(v.kbMoveWinToWs .. " + 0", wsaction.action('move', 10))

  -- Move window to workspace group #
  hl.bind(v.kbMoveWinToWsGroup .. " + 1", wsaction.action('move', 1, true))
  hl.bind(v.kbMoveWinToWsGroup .. " + 2", wsaction.action('move', 2, true))
  hl.bind(v.kbMoveWinToWsGroup .. " + 3", wsaction.action('move', 3, true))
  hl.bind(v.kbMoveWinToWsGroup .. " + 4", wsaction.action('move', 4, true))
  hl.bind(v.kbMoveWinToWsGroup .. " + 5", wsaction.action('move', 5, true))
  hl.bind(v.kbMoveWinToWsGroup .. " + 6", wsaction.action('move', 6, true))
  hl.bind(v.kbMoveWinToWsGroup .. " + 7", wsaction.action('move', 7, true))
  hl.bind(v.kbMoveWinToWsGroup .. " + 8", wsaction.action('move', 8, true))
  hl.bind(v.kbMoveWinToWsGroup .. " + 9", wsaction.action('move', 9, true))
  hl.bind(v.kbMoveWinToWsGroup .. " + 0", wsaction.action('move', 10, true))

  -- Move window to workspace -1/+1
  hl.bind("SUPER + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "-1", true }), {repeating = true})
  hl.bind("SUPER + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "+1", true }), { repeating = true })
  hl.bind("SUPER + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "+1", true }))
  hl.bind("SUPER + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "-1", true }))

  -- Move window to/from special workspace
  hl.bind("SUPER + SHIFT + U", hl.dsp.window.move({ workspace = "e+0", true }))
  hl.bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special:special", true }))

  -- Window groups
  hl.bind(v.kbWindowGroupCycleNext, hl.dsp.window.cycle_next(), { repeating = true })
  hl.bind(v.kbWindowGroupCyclePrev, hl.dsp.window.cycle_next({ direction = "prev" }), { repeating = true })
  hl.bind("CTRL + ALT + Tab", hl.dsp.group.next(), { repeating = true })
  hl.bind("CTRL + SHIFT + ALT + Tab", hl.dsp.group.prev(), { repeating = true })
  hl.bind(v.kbToggleGroup, hl.dsp.group.toggle())
  hl.bind(v.kbUngroup, hl.dsp.group.toggle({hl.get_active_window()}))
  hl.bind("SUPER + SHIFT + Comma", hl.dsp.group.lock({ action = "toggle" }))

  -- Window actions
  hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
  hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))
  hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
  hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
  hl.bind("SUPER + CTRL + H", hl.dsp.window.move({ direction = "l" }))
  hl.bind("SUPER + CTRL + L", hl.dsp.window.move({ direction = "r" }))
  hl.bind("SUPER + CTRL + K", hl.dsp.window.move({ direction = "u" }))
  hl.bind("SUPER + CTRL + J", hl.dsp.window.move({ direction = "d" }))

  -- Resize Windows
  hl.bind("SUPER + SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
  hl.bind("SUPER + SHIFT + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
  hl.bind("SUPER + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
  hl.bind("SUPER + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

  hl.bind("SUPER + Minus", hl.dsp.layout("splitratio -0.1"), { repeating = true })
  hl.bind("SUPER + Equal", hl.dsp.layout("splitratio 0.1"), { repeating = true })
  hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
  hl.bind(v.kbMoveWindow, hl.dsp.window.drag(), { mouse = true })
  hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
  hl.bind(v.kbResizeWindow, hl.dsp.window.resize(), { mouse = true })

  hl.bind("CTRL + SUPER + Backslash", hl.dsp.window.center({ respect_gaps = true }))
  hl.bind("CTRL + SUPER + ALT + Backslash", function()
    hl.dispatch(hl.dsp.window.resize({ exact_x = "55%", exact_y = "70%" }))
    hl.dispatch(hl.dsp.window.center({ respect_gaps = true }))
  end)
  hl.bind(v.kbPinWindow, hl.dsp.window.pin())
  hl.bind(v.kbWindowFullscreen, hl.dsp.window.fullscreen({ mode = 0 }))
  hl.bind(v.kbWindowBorderedFullscreen, hl.dsp.window.fullscreen({ mode = 1 }))
  hl.bind(v.kbToggleWindowFloating, hl.dsp.window.float({ action = "toggle" }))
  hl.bind(v.kbCloseWindow, hl.dsp.window.kill())

  -- Special workspace toggles
  hl.bind(v.kbSystemMonitor, hl.dsp.exec_cmd("app2unit -- gnome-system-monitor"))
  hl.bind(v.kbMusic, toggleWorkspace.toggle("music"))
  hl.bind(v.kbCommunication, toggleWorkspace.toggle("communication", {"ferdium:ferdium"}))
  hl.bind(v.kbTodo, toggleWorkspace.toggle("todo"))

  -- Apps
  hl.bind(v.kbTerminal, hl.dsp.exec_cmd("app2unit -- " .. v.terminal))
  hl.bind(v.kbBrowser, hl.dsp.exec_cmd("app2unit -- " .. v.browser))
  hl.bind(v.kbEditor, hl.dsp.exec_cmd("app2unit -- " .. v.editor))
  hl.bind("SUPER + G", hl.dsp.exec_cmd("app2unit -- github-desktop"))
  hl.bind(v.kbFileExplorer, hl.dsp.exec_cmd("app2unit -- " .. v.fileExplorer))
  hl.bind("SUPER + ALT + E", hl.dsp.exec_cmd("app2unit -- nemo"))
  hl.bind("CTRL + ALT + Escape", hl.dsp.exec_cmd("app2unit -- qps"))
  hl.bind("CTRL + ALT + V", hl.dsp.exec_cmd("app2unit -- better-control"))

  -- Utilities
  hl.bind("Print", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:screen-shot-and-record screenshot"), { locked = true })
  hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:screen-shot-and-record screenshot"), { locked = true })
  hl.bind("SUPER + ALT + R", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:screen-shot-and-record record"))
  hl.bind("SUPER + ALT + CTRL + R", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:screen-shot-and-record recordsound"))
  hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

  -- Volume
  hl.bind("XF86AudioMute", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call volume muteOutput"), { locked = true })
  hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call volume muteOutput"), { locked = true })
  hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; qs -c noctalia-shell ipc call volume increase"), { locked = true, repeating = true })
  hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; qs -c noctalia-shell ipc call volume decrease"), { locked = true, repeating = true })

  -- Clipboard and emoji picker
  hl.bind("SUPER + V", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call launcher clipboard"))

  -- User Defined
  hl.bind("SUPER + T", toggleWorkspace.toggle("email", {"flatpak:com.getmailspring.Mailspring:com.getmailspring.Mailspring"}))
  hl.bind("SUPER + P", hl.dsp.exec_cmd("rofi-rbw -a copy -t password --keybindings Alt+u:copy:username,Alt+t:copy:totp"))
  hl.bind("SUPER + W", hl.dsp.exec_cmd("wayscriber --active"))
  hl.bind("SUPER + A", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:assistant-panel toggle"))
  hl.bind("SUPER + N", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call bar toggle"))

  hl.bind("SUPER + Tab", hl.dsp.exec_cmd("hyprctl dispatch scrolloverview:overview toggle"))

  hl.bind("SUPER + SHIFT + CTRL + K", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:show-keys toggle"))
end)

hl.dispatch(hl.dsp.submap("global"))
