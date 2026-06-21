#!/bin/sh
xrdb -merge <<EOF
Xft.dpi: 96
Xcursor.size: 24
EOF

xrandr --output DP-0 --rate 144 --mode 1920x1080 --pos 0x0 --rotate left --output DP-4 --rate 144 --primary --mode 1920x1080 --pos 1080x420 --rotate normal
feh --no-fehbg --bg-scale $HOME/.config/wallpaper/current.jpg --bg-fill $HOME/.config/wallpaper/current.jpg
setxkbmap gb
