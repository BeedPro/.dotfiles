#!/bin/bash
if [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v bemenu >/dev/null 2>&1; then
    MENU="bemenu"
else
    MENU="dmenu"
fi

choice=$(ps -a -u $USER | awk '{print $1" "$4}' | tail -n +2 | $MENU -p "kill")

if [[ ! -z $choice ]]; then
  answer=$(echo -e "yes\nno" | $MENU -p "$choice will be killed?")
  selpid="$(echo $choice | awk '{print $1}')"
  if [[ $answer == "yes" ]]; then
    kill -9 $selpid
    notify-send "Kill $choice: success"
    exit 0
  fi
  notify-send "Kill $choice: aborted"
fi
