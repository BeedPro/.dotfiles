#!/usr/bin/env bash

set -e

APPDIR="$HOME/.local/share/applications"
mkdir -p "$APPDIR"

TERMINAL=alacritty

APPS=(
  "Godot|godot"
  "Chat|$HOME/.local/scripts/bulk-open chat"
  "Email|$HOME/.local/scripts/bulk-open email"
  "Libresprite|libresprite"
  'Calendar|firefox --new-window "https://calendar.google.com" &'
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
