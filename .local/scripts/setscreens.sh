#!/bin/bash

# Get the hostname
HOSTNAME=$(hostname)

# Main logic
if [ "$HOSTNAME" = "nimbus" ]; then
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        wlr-randr --output DP-1 --mode 1920x1080@143.854996
        wlr-randr --output DP-3 --mode 1920x1080@143.854996
    elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
        xrandr --output DP-0 --mode 1920x1080 --rate 144
        xrandr --output DP-4 --mode 1920x1080 --rate 144
    else
        echo "Unsupported session type: $XDG_SESSION_TYPE"
        exit 1
    fi
else
    exit 1
fi
