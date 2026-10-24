#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
plugins_dir="${HOME}/.config/omarchy/plugins"

while IFS=$'\t' read -r id url; do
  [[ -z "$id" || "$id" == \#* ]] && continue
  if [[ -e "$plugins_dir/$id" ]]; then
    printf 'Already installed: %s\n' "$id"
    continue
  fi
  omarchy plugin add "$url" --yes
done < "$script_dir/plugins.tsv"

# Enabled plugins and bar placement are managed by shell.json.
