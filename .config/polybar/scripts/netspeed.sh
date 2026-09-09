#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/colors.sh"
IFACE=$(ip route 2>/dev/null | awk '/default/ {print $5; exit}')
[[ -z $IFACE ]] && IFACE="wlan0"
read -r _ rx1 _ _ _ _ _ _ tx1 _ < <(grep "$IFACE:" /proc/net/dev 2>/dev/null | tr -s ' ' | cut -d: -f2 | xargs echo)
sleep 1
read -r _ rx2 _ _ _ _ _ _ tx2 _ < <(grep "$IFACE:" /proc/net/dev 2>/dev/null | tr -s ' ' | cut -d: -f2 | xargs echo)
rx1=${rx1:-0}; rx2=${rx2:-0}; tx1=${tx1:-0}; tx2=${tx2:-0}
down=$(awk "BEGIN{printf \"%.1f\", ($rx2-$rx1)/1024}")
up=$(awk "BEGIN{printf \"%.1f\", ($tx2-$tx1)/1024}")
echo "${faded_green} ${down}KB/s${RESET} ${faded_aqua} ${up}KB/s${RESET}"
