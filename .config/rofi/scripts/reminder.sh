#!/bin/bash
# reminder.sh — tiny reminders via dunst (Omarchy trigger.reminder port)
# Usage: reminder.sh [set|show|clear]
STORE="$HOME/.local/share/i3-reminders"
mkdir -p "$(dirname "$STORE")"
touch "$STORE"

case "${1:-set}" in
set)
  echo "In how many minutes?"
  read -r MIN
  echo "Message?"
  read -r MSG
  [[ "$MIN" =~ ^[0-9]+$ ]] || { echo "minutes must be a number"; exit 1; }
  ( sleep $((MIN * 60)) && notify-send 'Reminder' "$MSG" ) &
  printf '%s|%s\n' "$(date -d "+$MIN min" '+%H:%M')" "$MSG" >> "$STORE"
  echo "set: $MSG in $MIN min" ;;
show) cat "$STORE" ;;
clear) : > "$STORE"; echo "cleared" ;;
esac
