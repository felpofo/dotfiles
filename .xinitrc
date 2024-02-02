#!/bin/sh

[[ -f "$userresources" ]] && xrdb -merge -I$HOME ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for file in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$file" ] && . "$file"
  done

  unset file
fi

exec bspwm
