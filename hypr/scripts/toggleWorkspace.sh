#!/usr/bin/env bash

workspace_name="$1"
shift

if [[ -z "$workspace_name" ]]; then
  echo "Usage: $0 <workspace_name> app1:window_name1 [app2:window_name2 ...]"
  exit 1
fi

if [[ -n "$(hyprctl monitors -j | jq -r ".[] | select(.specialWorkspace.name == \"special:$workspace_name\")")" ]]; then
  hyprctl dispatch togglespecialworkspace "$workspace_name"
  exit 0
fi

# Toggle workspace (switch to it)
hyprctl dispatch togglespecialworkspace "$workspace_name"

# Process each app:window_name pair
for pair in "$@"; do
  app="${pair%%:*}"

  window_name="${pair#*:}"

  if [[ -z "$(hyprctl clients -j | jq ".[] | select(.class==\"$window_name\").class")" ]]; then
    echo "Starting $app"
    app2unit -- "$app" &>/dev/null
  else
    echo "Moving $window_name"
    hyprctl dispatch movetoworkspace "special:$workspace_name,class:$window_name"
  fi
done

