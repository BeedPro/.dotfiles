#!/usr/bin/env bash

set -e

APPDIR="$HOME/.local/share/applications"
mkdir -p "$APPDIR"

TERMINAL=alacritty

APPS=(
  "Godot|godot"
  "Chromium|chromium"
  "Helium|helium"
  "Chat|$HOME/.local/scripts/openapps chat"
  "Email|$HOME/.local/scripts/openapps email"
  "Bookmarks|$HOME/.local/scripts/openbms"
  "Libresprite|libresprite"
  "Vial|vial"
  'Google Calendar|firefox --new-window "https://calendar.google.com"'
  'GitHub|firefox --new-window "https://github.com"'
)

for entry in "${APPS[@]}"; do
  NAME="${entry%%|*}"
  EXEC="${entry#*|}"

  # Create a safe filename
  FILE_NAME=$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  DESKTOP_FILE="$APPDIR/$FILE_NAME.desktop"

  cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=$NAME
Exec=$EXEC
Type=Application
Terminal=false
EOF

  chmod +x "$DESKTOP_FILE"
  echo "Created $DESKTOP_FILE"
done

echo "All desktop files generated."
