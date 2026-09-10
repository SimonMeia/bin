#!/usr/bin/env bash
set -euo pipefail

CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config.ghostty"

# LIGHT="Apple System Colors Light"
# LIGHT="Breadog"
# LIGHT="Bluloco Light"
LIGHT="Catppuccin Latte"
DARK="Monokai Pro Spectrum"

if [[ ! -f "$CONFIG" ]]; then
    echo "Ghostty config introuvable: $CONFIG" >&2
    exit 1
fi

CURRENT="$(
    sed -n 's/^[[:space:]]*theme[[:space:]]*=[[:space:]]*//p' "$CONFIG" |
    tail -n 1
)"

case "$CURRENT" in
    "$LIGHT")
        NEXT="$DARK"
        ;;
    "$DARK")
        NEXT="$LIGHT"
        ;;
    *)
        # Si le thème actuel est autre chose, on part sur light.
        NEXT="$LIGHT"
        ;;
esac

sed -i -E \
    "s|^[[:space:]]*theme[[:space:]]*=.*$|theme = $NEXT|" \
    "$CONFIG"

# Méthode recommandée par Ghostty sous Linux/systemd.
if systemctl --user reload app-com.mitchellh.ghostty.service 2>/dev/null; then
    :
else
    # Fallback si Ghostty n'est pas géré par son service systemd.
    pkill -USR2 ghostty
fi

echo "Ghostty → $NEXT"
