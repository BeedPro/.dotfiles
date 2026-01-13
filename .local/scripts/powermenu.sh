#!/bin/bash
choice=$(echo -e "lock\nlogout\nsuspend\nhibernate\nreboot\npoweroff" | rofi -dmenu)

if [[ -f /tmp/power-lock ]]; then
  notify-send "Powermenu" "Power locked due to process"
  exit 0
fi

if [ "$choice" == "logout" ]; then
  pkill i3
elif [ "$choice" == "lock" ]; then
  "$LOCKER"
elif [ -n "$choice" ]; then
  systemctl "${choice,,}"
fi
