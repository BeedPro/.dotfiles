#!/bin/sh

if [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v bemenu >/dev/null 2>&1; then
    MENU="bemenu"
else
    MENU="dmenu"
fi

# Prompt the user with dmenu
choice=$(printf "yes\nno" | $MENU -i -p "Are you sure you want to quit?")

# Check the user's choice
if [ "$choice" = "yes" ]; then
    if pgrep -x dwm > /dev/null; then
        killall dwm
    elif pgrep -x dwl > /dev/null; then
        # dwl uses wlroots, so we send SIGTERM to quit cleanly
        killall dwl
    else
        notify-send "No known window manager (dwm/dwl) is running."
    fi
fi

