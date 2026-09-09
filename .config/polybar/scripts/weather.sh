#!/bin/bash
# weather.sh — polybar weather via wttr.in, cached 30 min (Omarchy weather port)
CACHE=/tmp/i3-weather.txt
if [[ ! -f $CACHE ]] || (( $(date +%s) - $(stat -c %Y "$CACHE") > 1800 )); then
  curl -s --max-time 8 'https://wttr.in/?format=%c+%t' -o "$CACHE" 2>/dev/null || echo "? --" > "$CACHE"
fi
cat "$CACHE"
