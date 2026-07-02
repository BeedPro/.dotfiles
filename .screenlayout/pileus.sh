#!/bin/bash

feh --no-fehbg --bg-scale $HOME/.config/wallpaper/current.jpg

xrdb -merge <<EOF
Xft.dpi: 96
Xcursor.size: 24
EOF

xset s off
xset -dpms
xset s noblank

# setxkbmap gb
