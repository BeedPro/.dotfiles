#!/bin/bash
# Dependencies (X11 only):
# maim, xclip, xdotool, notify-send

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
FINALFILE="$SCREENSHOT_DIR/$TIMESTAMP.png"

take_screenshot() {
    case "$1" in
        screen)
            maim "$FINALFILE"
            ;;
        window)
            maim -i "$(xdotool getactivewindow)" "$FINALFILE"
            ;;
        selection)
            maim -s -b 1 -c 0.89,0.75,0.98,1.0 "$FINALFILE"
            ;;
        *)
            echo "Invalid mode: $1" >&2
            exit 1
            ;;
    esac
}

if [ -n "$1" ]; then
    MODE="$1"
else
    echo "Usage: $0 [screen|window|selection]"
    exit 1
fi

take_screenshot "$MODE"
xclip -selection clipboard -t image/png -i "$FINALFILE"
notify-send "Screenshot taken" "$TIMESTAMP.png" -i "$FINALFILE"
