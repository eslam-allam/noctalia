#!/usr/bin/env bash

echo "Updating submodules..."
if ! git submodule update --init --recursive; then
  echo "Failed to update submodules!"
  exit 1
fi
echo "Submodules Updated successfully"

baseTarget="$HOME/.config"

hyprPluginsManifest="./hypr/plugins.toml"

function checkHyprlandPluginsDeps {
  if ! command -v hyprpm &> /dev/null; then
    echo "hyprpm not installed. Plugin installation not possible" >&2
    return 1;
  fi

  if ! command -v toml-cli &> /dev/null; then
    echo "toml-cli not installed. Cannot check hyprland plugins" >&2
    return 1;
  fi

  if [[ ! -f "$hyprPluginsManifest" ]]; then 
    echo "hyprPluginsManifest not found in '$hyprPluginsManifest'" >&2
    return 1
  fi

  return 0
}

function hyprlandPluginsEnabled {
  if ! checkHyprlandPluginsDeps; then
    return 1
  fi
  local result
  result="$(toml-cli get "$hyprPluginsManifest" enabled)"
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
  result="$(toml-cli get "$hyprPluginsManifest" plugins)"
  if [[ -z "$result" ]]; then
    echo "Failed to get plugins from $hyprPluginsManifest" >&2
    return 1
  fi

  echo "$result"
}

function connect {
  component="$1"
  target="$baseTarget/$component"
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

meta_directory='meta-package'
targets=('hypr' 'rofi')

if ! pushd "$meta_directory" &>/dev/null; then
  echo "Failed to change to meta directory $meta_directory"
  exit 1
fi
if ! yay -B -i --needed .; then
  echo 'Failed to install meta package'
  exit 1
fi
if ! popd &>/dev/null; then
  echo "Failed to return to original directory after meta installation $meta_directory"
  exit 1
fi

for target in "${targets[@]}"; do
  if ! connect "$target"; then
    exit 1
  fi
done


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


installedPlugins=()
failedPlugins=()
enabledPlugins=()
disabledPlugins=()
failedToEnablePlugins=()

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
        disabledPlugins+=("$name")
        continue 
    fi
    echo "  -> This plugin is active."
    if ! hyprpm list | grep -q "$name"; then
      echo "Plugin $name not installed. Installing..."
      if ! hyprpm add "$url"; then
        echo "Failed to install plugin $name"
        failedPlugins+=("$name")
        continue 
      fi
      echo "Plugin $name installed successfully"
      installedPlugins+=("$name")
    else
      echo "Plugin $name already installed.."
    fi 

    echo "Enabling plugin $name..."
    if ! hyprpm enable "$name"; then
      echo "Failed to enable $name"
      failedToEnablePlugins+=("$name")
      continue 
    fi
    enabledPlugins+=("$name")
done < <(echo "$plugins" | jq -r '.[] | "\(.name) \(.url) \(.enabled)"')

echo "Reloading hyprpm"
if ! hyprpm reload; then
  echo "Failed to reload hyprpm!!"
  exit 1
fi

echo "Plugins updated successfully!"

echo -e "\n--- Hyprland Plugin Summary ---"
# 1. Successful Installations
if [[ ${#installedPlugins[@]} -gt 0 ]]; then
    echo "✅ Successfully Installed:"
    for plugin in "${installedPlugins[@]}"; do
        echo "   - $plugin"
    done
fi

# 2. Failed Installations
if [[ ${#failedPlugins[@]} -gt 0 ]]; then
    echo "❌ Failed to Install:"
    for plugin in "${failedPlugins[@]}"; do
        echo "   - $plugin"
    done
fi

# 3. Enabled Plugins
if [[ ${#enabledPlugins[@]} -gt 0 ]]; then
    echo "▶️  Successfully Enabled:"
    for plugin in "${enabledPlugins[@]}"; do
        echo "   - $plugin"
    done
fi

# 4. Enabled Plugins
if [[ ${#disabledPlugins[@]} -gt 0 ]]; then
    echo "⏸  Successfully Disabled:"
    for plugin in "${disabledPlugins[@]}"; do
        echo "   - $plugin"
    done
fi

# 5. Failed to Enable
if [[ ${#failedToEnablePlugins[@]} -gt 0 ]]; then
    echo "⚠️  Failed to Enable (Installed but inactive):"
    for plugin in "${failedToEnablePlugins[@]}"; do
        echo "   - $plugin"
    done
fi

# Final check if everything was empty
if [[ ${#installedPlugins[@]} -eq 0 && ${#failedPlugins[@]} -eq 0 && ${#enabledPlugins[@]} -eq 0 ]]; then
    echo "No actions were performed."
fi

echo "-------------------------------"

echo 'Done...'
