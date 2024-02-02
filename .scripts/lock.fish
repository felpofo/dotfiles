#!/bin/fish

LANG=pt_BR.UTF-8 i3lock \
  --image ~/.lockscreen \
  --fill \
  --ignore-empty-password \
  --screen 0 \
  --clock \
  --ringver-color 8aadf4 \
  --ringwrong-color ed8796 \
  --keyhl-color eed49f \
  --bshl-color ed8796 \
  --time-color 24273a \
  --date-color 24273a \
  --time-str '%H:%M' \
  --date-str '%d de %B de %Y' \
  --time-align 1 \
  --date-align 1 \
  --time-font 'Lilita One' \
  --date-font 'Lilita One' \
  --time-size 96 \
  --date-size 38 \
  --time-pos 32:1002 \
  --date-pos 32:1048 \
  --bar-indicator \
  --bar-base-width 8 \
  --bar-color 24273a \
  --bar-total-width 1920 \
  --redraw-thread
