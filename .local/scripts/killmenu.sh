#!/bin/bash
choice=$(ps -a -u $USER | awk '{print $1" "$4}' | tail -n +2 | rofi -dmenu -p "kill")

if [[ ! -z $choice ]]; then
  answer=$(echo -e "yes\nno" | rofi -dmenu -p "$choice will be killed?")
  selpid="$(echo $choice | awk '{print $1}')"
  if [[ $answer == "yes" ]]; then
    kill -9 $selpid
    notify-send "Kill $choice: success"
    exit 0
  fi
  notify-send "Kill $choice: aborted"
fi
