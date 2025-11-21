#!/usr/bin/env bash

APP=$1

pids=$(pgrep "$APP")

if [[ -z "$pids" ]]; then
  app2unit -- "$APP"
  exit $?
else
  for pid in $pids; do
    class=$(hyprctl clients -j | jq -r ".[] | select(.pid==$pid).class")
    if [[ -z "$class" ]]; then
      continue
    fi
    hyprctl dispatch movetoworkspace "+0,class:$class" > /dev/null
    exit $?
  done
fi
