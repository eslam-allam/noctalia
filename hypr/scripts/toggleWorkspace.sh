#!/usr/bin/env bash

workspace_name="$1"
shift

function usage  {
  echo "Usage: $0 <workspace_name> [modifier:]app1:window_name1 [[modifier:]app2:window_name2 ...]"
  exit 1
}

if [[ -z "$workspace_name" ]]; then
  usage 
fi

if [[ -n "$(hyprctl monitors -j | jq -r ".[] | select(.specialWorkspace.name == \"special:$workspace_name\")")" ]]; then
  hyprctl dispatch togglespecialworkspace "$workspace_name"
  exit 0
fi

# Toggle workspace (switch to it)
hyprctl dispatch togglespecialworkspace "$workspace_name"

# Process each app:window_name pair
for pair in "$@"; do
  IFS=":" read -ra pieces <<< "$pair"
  num_pieces=${#pieces[@]}
  command=""
  class=""
  case $num_pieces in
    2)
      command="app2unit -- ${pieces[0]} &>/dev/null"
      class="${pieces[1]}"
      ;;
    3)
      modifier="${pieces[0]}"
      case "$modifier" in
        "flatpak")
          command="flatpak run ${pieces[1]} > /dev/null 2>&1 &"
          class="${pieces[2]}"
          ;;
        *)
          echo "Modifier $modifier not supported"
          exit 1
          ;;
      esac
      ;;
    *)
      usage
      ;;
  esac

  if [[ -z "$(hyprctl clients -j | jq ".[] | select(.class==\"$class\").class")" ]]; then
    echo "Starting $command"
    eval "$command"
  else
    echo "Moving $class"
    hyprctl dispatch movetoworkspace "special:$workspace_name,class:$class"
  fi
done

