#!/bin/bash

feh --no-fehbg --bg-scale $HOME/.config/wallpaper/current.jpg

xrdb -merge <<EOF
Xft.dpi: 120
Xcursor.size: 32
EOF

xset s off
xset -dpms
xset s noblank

# setxkbmap gb
