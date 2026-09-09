#!/bin/sh
# polybar launch — auto-detects monitor so config works on any machine
# koli's bug: hardcoded eDP-1 fails on machines where monitor is eDP, HDMI-1, DP-1, etc.
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.2; done

# detect primary/connected monitor
MONITOR=""
if command -v polybar >/dev/null 2>&1; then
  MONITOR=$(polybar --list-monitors 2>/dev/null | cut -d: -f1 | head -n1)
fi
if [ -z "$MONITOR" ] && command -v xrandr >/dev/null 2>&1; then
  MONITOR=$(xrandr --query 2>/dev/null | grep " connected" | cut -d" " -f1 | head -n1)
fi
export MONITOR
# if still empty, polybar will pick first monitor itself (monitor = "")

polybar main &
