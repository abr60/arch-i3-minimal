#!/bin/bash
# arch-i3-minimal powermenu — rofi power menu (Omarchy SUPER+Escape equivalent)
CHOICE=$(printf "Lock\nSuspend\nLogout\nReboot\nShutdown" | rofi -dmenu -p "Power" -theme ~/.config/rofi/config.rasi)
case "$CHOICE" in
  Lock)     i3lock -c 1a1a1a ;;
  Suspend)  systemctl suspend ;;
  Logout)   i3-msg exit ;;
  Reboot)   systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
