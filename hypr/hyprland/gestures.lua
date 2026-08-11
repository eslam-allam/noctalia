local v = require("variables")

hl.config({
	gestures = {
		workspace_swipe_distance = 700,
		workspace_swipe_cancel_ratio = 0.15,
		workspace_swipe_min_speed_to_force = 5,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 10,
		workspace_swipe_create_new = true,
	},
})

hl.gesture({ fingers = v.workspaceSwipeFingers, direction = "horizontal", action = "workspace" })
hl.gesture({
	fingers = v.workspaceSwipeFingers,
	direction = "up",
	action = {
		start = function()
			hl.dispatch(hl.dsp.workspace.toggle_special())
		end,
	},
})

local volume_gesture = function(change)
	hl.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. math.abs(change) .. "%" .. (change < 0 and "-" or "+"))
end
hl.gesture({
	fingers = v.gestureFingers,
	direction = "vertical",
	action = {
		start = function(e)
			volume_gesture(-0.25 * e.delta.y)
		end,
		update = function(e)
			volume_gesture(-0.25 * e.delta.y)
		end,
	},
})
