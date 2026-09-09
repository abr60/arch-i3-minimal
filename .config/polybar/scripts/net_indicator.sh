#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/colors.sh"
# wifi check via nmcli or iwconfig
if command -v nmcli >/dev/null 2>&1; then
  wifi_state=$(nmcli -t -f TYPE,STATE device 2>/dev/null | grep -c "wifi:connected")
  if (( wifi_state > 0 )); then wifi="${faded_green}${RESET}"; else wifi="${dark0_soft}${RESET}"; fi
  vpn=$(nmcli -t -f TYPE,STATE device 2>/dev/null | grep -c "vpn:connected")
  if (( vpn > 0 )); then vpn_i="${faded_green}${RESET}"; else vpn_i="${dark0_soft}${RESET}"; fi
else
  ESSID=$(iwconfig wlan0 2>/dev/null | grep ESSID | cut -d: -f2 | xargs)
  if [[ $ESSID != "off/any" && -n $ESSID ]]; then wifi="${faded_green}${RESET}"; else wifi="${dark0_soft}${RESET}"; fi
  vpn_i="${dark0_soft}${RESET}"
fi
echo "$wifi $vpn_i"
