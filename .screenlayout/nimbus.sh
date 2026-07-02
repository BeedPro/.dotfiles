#!/bin/sh

feh --no-fehbg \
  --bg-scale "$HOME/.config/wallpaper/current.jpg" \
  --bg-fill "$HOME/.config/wallpaper/current.jpg"

xset s off
xset -dpms
xset s noblank

# setxkbmap gb
