#!/usr/bin/env bash

set -e

APPDIR="$HOME/.local/share/applications"
mkdir -p "$APPDIR"

TERMINAL=$1

APPS=(
  "RMPC|$TERMINAL -e /home/beed/.cargo/bin/rmpc"
  "Neovim|$TERMINAL -e nvim"
  "Yazi|$TERMINAL -e yazi"
  "Pulsemixer|$TERMINAL -e pulsemixer"
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
