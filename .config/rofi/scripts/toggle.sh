#!/bin/bash
# toggle.sh — Omarchy trigger.toggle port (touchpad/idle/bar/notifications)
# Usage: toggle.sh [touchpad|idle|bar|notify|state] [--quiet prints only new state]
ACTION="$1"

touchpad_id() { xinput list --id-only "$(xinput list --name-only | grep -iE 'touchpad|trackpoint' | head -1)" 2>/dev/null; }
touchpad_on() { xinput list-props "$(touchpad_id)" 2>/dev/null | grep -q 'Device Enabled.*1$'; }

case "$ACTION" in
touchpad)
  ID=$(touchpad_id); [[ -z $ID ]] && exit 1
  if touchpad_on; then xinput disable "$ID"; else xinput enable "$ID"; fi ;;
idle)
  # Stay Awake: xss-lock running = idle-lock armed
  if pgrep -x xss-lock >/dev/null; then pkill -x xss-lock; else xss-lock -- i3lock -c 1a1a1a & disown; fi ;;
bar)
  if pgrep -x polybar >/dev/null; then pkill -x polybar; else "$HOME/.config/polybar/launch.sh" & disown; fi ;;
notify)
  dunstctl set-paused toggle ;;
state)
  TP="off"; touchpad_on 2>/dev/null && TP="on"
  IDLE="off"; pgrep -x xss-lock >/dev/null && IDLE="on"
  BAR="off"; pgrep -x polybar >/dev/null && BAR="on"
  NTF="on"; dunstctl is-paused 2>/dev/null | grep -q true && NTF="off"
  printf 'touchpad=%s idle=%s bar=%s notify=%s\n' "$TP" "$IDLE" "$BAR" "$NTF" ;;
esac
