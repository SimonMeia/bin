#!/usr/bin/env bash
set -euo pipefail

command -v lig >/dev/null || { echo "lig doit être installé." >&2; exit 1; }

source_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)/specs"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/lig"
specs_dir="$config_dir/specs"

# Check all destinations before installing any links.
for spec in "$source_dir"/*.toml; do
    destination="$specs_dir/${spec##*/}"
    if [[ -e "$destination" || -L "$destination" ]]; then
        if [[ ! -L "$destination" || "$(readlink -- "$destination")" != "$spec" ]]; then
            printf 'Fichier déjà présent, installation interrompue : %s\n' "$destination" >&2
            exit 1
        fi
    fi
done

mkdir -p -- "$specs_dir"
for spec in "$source_dir"/*.toml; do
    destination="$specs_dir/${spec##*/}"
    [[ -L "$destination" ]] || ln -s -- "$spec" "$destination"
done

if [[ ! -e "$config_dir/config.toml" && ! -L "$config_dir/config.toml" ]]; then
    printf '[behavior]\ncomplete_commands = true\n' > "$config_dir/config.toml"
else
    printf 'Configuration conservée : %s/config.toml\n' "$config_dir"
    printf 'Pour suggérer les noms de commandes pendant la saisie : complete_commands = true dans [behavior].\n'
fi

lig specs check "$specs_dir"/*.toml
printf 'Complétions installées. Ouvre un nouveau terminal pour les charger.\n'
