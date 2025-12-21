#!/bin/bash
if [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v bemenu >/dev/null 2>&1; then
    MENU="bemenu -p power"
    LOCKER="$HOME/.local/scripts/waylock.sh"
else
    MENU="dmenu -p power"
    LOCKER="slock"
fi

choice=$(echo -e "lock\nlogout\nsuspend\nhibernate\nreboot\npoweroff" | $MENU)

if [[ -f /tmp/power-lock ]]; then
  notify-send "Powermenu" "Power locked due to process"
  exit 0
fi

if [ "$choice" == "logout" ]; then
  pkill -KILL -u "$USER"
elif [ "$choice" == "lock" ]; then
  "$LOCKER"
elif [ -n "$choice" ]; then
  systemctl "${choice,,}"
fi
