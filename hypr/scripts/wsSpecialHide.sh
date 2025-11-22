#!/usr/bin/env bash

if ! command -v caelestia >/dev/null; then
  echo "caelestia is not installed"
  exit 1
fi

if ! command -v hyprctl >/dev/null; then
  echo "hyprctl is not installed"
  exit 1
fi

if ! command -v jq >/dev/null; then
  echo "jq is not installed"
  exit 1
fi

if test -z "$1"; then
  echo "Usage: $0 <workspace|all>"
  exit 1
fi

if test "$1" = 'all'; then
  workspaces=$(hyprctl workspaces -j | jq -r '.[] | select(has("monitor")) | .name')
else 
  workspaces="special:$1"
fi

currentMonitor=$(hyprctl activeworkspace -j | jq -r .monitor)
for workspace in $workspaces; do
  monitors=$(hyprctl monitors -j)
  if [[ "$workspace" == "special:"* ]]; then
    workspaceMonitor="$(echo "$monitors" | jq -r '.[] | select(.specialWorkspace.name == "'"$workspace"'") | .name')"
    if test -z "$workspaceMonitor"; then
      continue
    fi
    workspace=${workspace#"special:"}
    if ! "$(dirname "$0")/toggleWorkspace.sh" "$workspace" >/dev/null; then
      notify-send -u critical -a 'Workspace Toggle' "Failed to toggle workspace $workspace" ''
      exit 1
    fi

    if [[ "$workspaceMonitor" != "$currentMonitor" ]]; then
      if ! caelestia toggle "$workspace" >/dev/null; then
        notify-send -u critical -a 'Workspace Toggle' "Failed to toggle workspace $workspace" ''
        exit 1
      fi
    fi
  fi
done

notify-send -a 'Workspace Toggle' "Toggled all workspaces successfully" ''
