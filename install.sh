#!/usr/bin/env bash

baseTarget="$HOME/.config"

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
if ! makepkg --si -f --nosign -i; then
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

echo 'Done...'
