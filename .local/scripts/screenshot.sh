#!/bin/bash
# Dependencies:
# Wayland: grim, slurp, wl-copy, bemenu, nsxiv
# X11: maim, xclip, xdotool, dmenu, nsxiv
# Common: notify-send

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
FINALFILE="$SCREENSHOT_DIR/$TIMESTAMP.png"

# Determine environment
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    BACKEND="wayland"
else
    BACKEND="x11"
fi

# Take screenshot
take_screenshot() {
    case "$1" in
        screen)
            [ "$BACKEND" = "wayland" ] && grim "$FINALFILE" || maim "$FINALFILE"
            ;;
        window)
            if [ "$BACKEND" = "wayland" ]; then
                notify-send "Screenshot Failed" "Active window capture is not supported in dwl"
                exit 1
            else
                maim -i "$(xdotool getactivewindow)" "$FINALFILE"
            fi
            ;;
        selection)
            [ "$BACKEND" = "wayland" ] && slurp -c '#cba6f7ff' -w 1 | grim -g - "$FINALFILE" || maim -s -b 1 -c 0.89,0.75,0.98,1.0 "$FINALFILE"
            ;;
        *)
            echo "Invalid mode: $1" >&2
            exit 1
            ;;
    esac
}

# Get mode from argument
if [ -n "$1" ]; then
    MODE="$1"
else
    echo "Usage: $0 [screen|window|selection]"
    exit 1
fi

take_screenshot "$MODE"

# Copy to clipboard
if [ "$BACKEND" = "wayland" ]; then
    wl-copy < "$FINALFILE"
else
    xclip -selection clipboard -t image/png -i "$FINALFILE"
fi

# nsxiv "$FINALFILE"
notify-send "Screenshot taken" $TIMESTAMP.png -i "$FINALFILE"
