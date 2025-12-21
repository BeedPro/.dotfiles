#!/bin/sh

run() {
  "$@" &
}

run_once() {
  if ! pgrep -x "$(basename "$1")" > /dev/null; then
    "$@" &
  fi
}


# WALL=$($HOME/.local/scripts/random-wall)
# echo "$WALL" > $HOME/.config/wallpaper/wall-path
# echo "$WALL" >> $HOME/.config/wallpaper/history-path
# cp $WALL $HOME/.config/wallpaper/current.jpg
cp $HOME/.config/wallpaper/current.jpg /tmp/wallpaper.jpg

run_once nm-applet
run_once emacs --daemon
run_once gtk-launch syncthing-start
run_once dunst
run_once mpd
run_once /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1
run_once start-espanso
run_once $HOME/.local/scripts/setscreens.sh


run flatpak run org.keepassxc.KeePassXC
run flatpak run eu.betterbird.Betterbird
run flatpak run com.borgbase.Vorta

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  run_once swaybg -i $HOME/.config/wallpaper/current.jpg -m fill
  run_once $HOME/.local/scripts/refresh-someblocks
  run_once $HOME/.local/scripts/wayobs-setup
  run_once beeper-wayland
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
  run_once xss-lock --transfer-sleep-lock -- slock --nofork
  run_once picom -b
  run_once $HOME/.screenlayout/set-screens.sh
  run_once $HOME/.local/scripts/xunblank
  run_once dwmblocks
  run_once beeper
else
  echo "Unsupported session type: $XDG_SESSION_TYPE"
fi
