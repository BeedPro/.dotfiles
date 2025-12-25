#!/bin/sh
nm-applet &
gtk-launch syncthing-start &
dunst &
mpd
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

flatpak run org.keepassxc.KeePassXC &
flatpak run eu.betterbird.Betterbird &
flatpak run com.borgbase.Vorta &
beeper &

xss-lock --transfer-sleep-lock -- slock --nofork &
picom -b
feh --no-fehbg --bg-scale $HOME/.config/wallpaper/current.jpg
xset dpms 0 0 0 && xset s noblank  && xset s off
dwmblocks &
