#!/usr/bin/env bash

BASE_TARGET="$HOME/.config"
META_DIRECTORY='meta-package'
TARGETS=('hypr' 'rofi')

HYPR_PLUGINS_MANIFEST="./hypr/plugins.toml"

INSTALLED_PLUGINS=()
FAILED_PLUGINS=()
ENABLED_PLUGINS=()
DISABLED_PLUGINS=()
FAILED_TO_ENABLE_PLUGINS=()

function checkHyprlandPluginsDeps {
  if ! command -v hyprpm &>/dev/null; then
    echo "hyprpm not installed. Plugin installation not possible" >&2
    return 1
  fi

  if ! command -v toml-cli &>/dev/null; then
    echo "toml-cli not installed. Cannot check hyprland plugins" >&2
    return 1
  fi

  if [[ ! -f "$HYPR_PLUGINS_MANIFEST" ]]; then
    echo "hyprPluginsManifest not found in '$HYPR_PLUGINS_MANIFEST'" >&2
    return 1
  fi

  return 0
}

function hyprlandPluginsEnabled {
  if ! checkHyprlandPluginsDeps; then
    return 1
  fi
  local result
  result="$(toml-cli get "$HYPR_PLUGINS_MANIFEST" enabled)"
  if [[ -z "$result" ]]; then
    echo "false"
    return 0
  fi

  echo "$result"
  return 0
}

function getHyprlandPlugins {
  if ! checkHyprlandPluginsDeps; then
    return 1
  fi

  local result
  result="$(toml-cli get "$HYPR_PLUGINS_MANIFEST" plugins)"
  if [[ -z "$result" ]]; then
    echo "Failed to get plugins from $HYPR_PLUGINS_MANIFEST" >&2
    return 1
  fi

  echo "$result"
}

function connect {
  component="$1"
  target="$BASE_TARGET/$component"
  backup="$target.$(date +%Y%m%d).bak"

  link_source="$PWD/$component"

  if [[ -e "$target" ]]; then
    if [[ "$(readlink -f "$target")" = "$link_source" ]]; then
      echo "Target $target is already linked to $link_source"
      return 0
    fi
    if ! mv "$target" "$backup"; then
      echo "Failed to backup $target to $backup"
      return 1
    fi
  fi

  if ! ln -s "$link_source" "$target"; then
    echo "Failed to link $link_source to $target"
    return 1
  fi

}

function installMeta {
  echo "Installing meta package..."

  if ! pushd "$META_DIRECTORY" &>/dev/null; then
    echo "Failed to change to meta directory $META_DIRECTORY"
    exit 1
  fi
  if ! yay -B -i --needed .; then
    echo 'Failed to install meta package'
    exit 1
  fi
  if ! popd &>/dev/null; then
    echo "Failed to return to original directory after meta installation $META_DIRECTORY"
    exit 1
  fi

}

function linkTargets {
  echo "Linking targets..."

  for target in "${TARGETS[@]}"; do
    if ! connect "$target"; then
      exit 1
    fi
  done
}

function installHyprlandPlugins {
  echo 'Checking hyprland plugins...'

  if ! enabled="$(hyprlandPluginsEnabled)"; then
    echo "Failed to check if hyprlandPluginsEnabled"
    exit 1
  fi

  if [[ "$enabled" = "false" ]]; then
    echo "Hyprland plugins are disabled. Skipping hyprland plugins installation"
    exit 0
  fi

  if ! plugins="$(getHyprlandPlugins)"; then
    echo "Failed to fetch hyprland plugins..."
    exit 1
  fi

  if [[ -z "$plugins" ]]; then
    echo "No hyprland plugins found. Skipping hyprland plugins installation"
    exit 0
  fi

  echo "Found Plugins: $plugins"

  echo "Updating hyprpm..."

  if ! hyprpm update; then
    echo "Failed to update hyprpm!!"
    exit 1
  fi

  while read -r name url enabled; do
    echo "Processing Plugin: $name"
    echo "  URL: $url"
    echo "  Status: $enabled"

    if [[ "$enabled" == "false" ]]; then
      echo "  -> This plugin is inactive. Disabling if installed..."
      if hyprpm list | grep -q "$name"; then
        hyprpm disable "$name"
      fi
      DISABLED_PLUGINS+=("$name")
      continue
    fi
    echo "  -> This plugin is active."
    if ! hyprpm list | grep -q "$name"; then
      echo "Plugin $name not installed. Installing..."
      if ! hyprpm add "$url"; then
        echo "Failed to install plugin $name"
        FAILED_PLUGINS+=("$name")
        continue
      fi
      echo "Plugin $name installed successfully"
      INSTALLED_PLUGINS+=("$name")
    else
      echo "Plugin $name already installed.."
    fi

    echo "Enabling plugin $name..."
    if ! hyprpm enable "$name"; then
      echo "Failed to enable $name"
      FAILED_TO_ENABLE_PLUGINS+=("$name")
      continue
    fi
    ENABLED_PLUGINS+=("$name")
  done < <(echo "$plugins" | jq -r '.[] | "\(.name) \(.url) \(.enabled)"')

  echo "Reloading hyprpm"
  if ! hyprpm reload; then
    echo "Failed to reload hyprpm!!"
    exit 1
  fi

  echo "Plugins updated successfully!"
}

function printPluginsStatus {
  echo -e "\n--- Hyprland Plugin Summary ---"
  # 1. Successful Installations
  if [[ ${#INSTALLED_PLUGINS[@]} -gt 0 ]]; then
    echo "✅ Successfully Installed:"
    for plugin in "${INSTALLED_PLUGINS[@]}"; do
      echo "   - $plugin"
    done
  fi

  # 2. Failed Installations
  if [[ ${#FAILED_PLUGINS[@]} -gt 0 ]]; then
    echo "❌ Failed to Install:"
    for plugin in "${FAILED_PLUGINS[@]}"; do
      echo "   - $plugin"
    done
  fi

  # 3. Enabled Plugins
  if [[ ${#ENABLED_PLUGINS[@]} -gt 0 ]]; then
    echo "▶️  Successfully Enabled:"
    for plugin in "${ENABLED_PLUGINS[@]}"; do
      echo "   - $plugin"
    done
  fi

  # 4. Enabled Plugins
  if [[ ${#DISABLED_PLUGINS[@]} -gt 0 ]]; then
    echo "⏸  Successfully Disabled:"
    for plugin in "${DISABLED_PLUGINS[@]}"; do
      echo "   - $plugin"
    done
  fi

  # 5. Failed to Enable
  if [[ ${#FAILED_TO_ENABLE_PLUGINS[@]} -gt 0 ]]; then
    echo "⚠️  Failed to Enable (Installed but inactive):"
    for plugin in "${FAILED_TO_ENABLE_PLUGINS[@]}"; do
      echo "   - $plugin"
    done
  fi

  # Final check if everything was empty
  if [[ ${#INSTALLED_PLUGINS[@]} -eq 0 && ${#FAILED_PLUGINS[@]} -eq 0 && ${#ENABLED_PLUGINS[@]} -eq 0 ]]; then
    echo "No actions were performed."
  fi

  echo "-------------------------------"
  hyprpm list
  echo "-------------------------------"
}

echo "Updating submodules..."
if ! git submodule update --init --recursive; then
  echo "Failed to update submodules!"
  exit 1
fi
echo "Submodules Updated successfully"

installMeta
linkTargets
installHyprlandPlugins
printPluginsStatus

echo 'Done...'
