#!/bin/sh

[[ -f "$userresources" ]] && xrdb -merge -I$HOME ~/.Xresources

exec bspwm
