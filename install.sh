#!/usr/bin/env bash

hyprTarget="$HOME/.config/hypr"
hyprBackup="$hyprTarget.$(date +%Y%m%d).bak"

if [[ -e "$hyprTarget" ]]; then
  if ! mv "$hyprTarget" "$hyprBackup"; then
    echo "Failed to backup $hyprTarget to $hyprBackup"
    exit 1
  fi
fi

if ! ln -s "$PWD/hypr" "$hyprTarget"; then
  echo "Failed to link $PWD/hypr to $hyprTarget"
  exit 1
fi
