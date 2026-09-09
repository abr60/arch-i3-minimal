#!/bin/bash
# bluetooth.sh — rofi bluetoothctl menu (Omarchy omarchy.bluetooth port)
THEME="$HOME/.config/rofi/config.rasi"
powered() { bluetoothctl show 2>/dev/null | grep -q 'Powered: yes'; }

POWER="Power: $(powered && echo on || echo off)"
SEL=$(printf '%s\n%s\n%s\n%s\n' "$POWER" 'Scan + connect' 'Disconnect' 'Paired devices' | rofi -dmenu -p 'Bluetooth' -theme "$THEME")

case "$SEL" in
'Power: off') bluetoothctl power on ;;
'Power: on')  bluetoothctl power off ;;
'Scan + connect')
  bluetoothctl --timeout 8 scan on &>/dev/null
  DEV=$(bluetoothctl devices 2>/dev/null | sed 's/^Device //' | rofi -dmenu -p 'Connect' -theme "$THEME")
  MAC="${DEV%% *}"
  [[ -n $MAC ]] && bluetoothctl pair "$MAC" && bluetoothctl connect "$MAC" ;;
Disconnect)
  DEV=$(bluetoothctl devices Connected 2>/dev/null | sed 's/^Device //' | rofi -dmenu -p 'Disconnect' -theme "$THEME")
  MAC="${DEV%% *}"
  [[ -n $MAC ]] && bluetoothctl disconnect "$MAC" ;;
'Paired devices')
  bluetoothctl devices Paired 2>/dev/null | sed 's/^Device //' | rofi -dmenu -p 'Paired' -theme "$THEME" ;;
esac
