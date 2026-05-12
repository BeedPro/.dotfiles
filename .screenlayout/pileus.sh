#!/bin/bash

xrdb -merge <<EOF
Xft.dpi: 96
Xcursor.size: 24
EOF

feh --no-fehbg --bg-scale $HOME/.config/wallpaper/current.jpg
