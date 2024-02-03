#!/bin/fish

killall border.fish
killall mpd.fish

bspc quit

mpd --kill

killall dunst
killall sxhkd

#killall easyeffects
#killall pipewire
#killall pipewire-pulse

killall polkit-mate-authentication-agent-1
killall xdg-desktop-portal-gtk
killall xdg-desktop-portal

killall xdg-document-portal
killall xdg-permission-store

