#!/bin/bash

IMAGE=/tmp/wallpaper.jpg

# Lock the screen using swaylock-effects with pixelation on the screenshot
swaylock \
  --color 11111b \
  --inside-color 313244 \
  --inside-clear-color a6e3a1 \
  --inside-ver-color 89b4fa \
  --inside-wrong-color f38ba8 \
  --ring-color 45475a \
  --ring-clear-color a6e3a1 \
  --ring-ver-color 89b4fa \
  --ring-wrong-color f38ba8 \
  --line-color 181825 \
  --line-clear-color a6e3a1 \
  --line-ver-color 89b4fa \
  --line-wrong-color f38ba8 \
  --separator-color 1e1e2e \
  --text-color cdd6f4 \
  --text-clear-color a6e3a1 \
  --text-ver-color 89b4fa \
  --text-wrong-color f38ba8 \
  --key-hl-color f9e2af \
  --bs-hl-color f38ba8 \
  --indicator-radius 24 \
  --indicator-thickness 8 \
  --font 'GohuFont 14 Nerd Font' \
  --font-size 12 \
  --show-failed-attempts \
  # --image $IMAGE
