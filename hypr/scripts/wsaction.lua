local M = {}

--- Actions a workspace group or a workspace within a group
--- @param dispatcher_type string 'focus' or 'move'
--- @param target number The target index (1-10)
--- @param is_group boolean? True to target the group ID, False to target workspace within the current group
function M.action(dispatcher_type, target, is_group)
  if is_group == nil then
    is_group = false
  end
  local active_ws_info = hl.get_active_workspace()
  if not active_ws_info or not active_ws_info.id then
    return hl.dsp.no_op()
  end

  local active_ws = active_ws_info.id
  local target_ws

  if is_group then
    -- Move to group: (target - 1) * 10 + (active_ws % 10)
    target_ws = (target - 1) * 10 + (active_ws % 10)
  else
    -- Move to ws in group: floor((active_ws - 1) / 10) * 10 + target
    target_ws = math.floor((active_ws - 1) / 10) * 10 + target
  end

  -- Construct structured dispatcher table based on target action type
  local dsp_action
  if dispatcher_type == "move" then
    dsp_action = hl.dsp.window.move({ workspace = tostring(target_ws) })
  else
    dsp_action = hl.dsp.focus({ workspace = tostring(target_ws) })
  end

  return dsp_action
end

return M
