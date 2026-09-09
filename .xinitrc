#!/bin/sh
# arch-i3-minimal .xinitrc
xrdb -merge ~/.Xresources 2>/dev/null
xset r rate 250 40
exec i3
