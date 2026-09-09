#!/bin/sh
# terminate running bars, relaunch
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.2; done
polybar main &
