#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/colors.sh"
ESSID=$(iwconfig wlan0 2>/dev/null | grep ESSID | cut -d: -f2 | xargs)
[[ $ESSID == "off/any" || -z $ESSID ]] && CONNECTED=0 || CONNECTED=1
WIFI_Q=$(awk 'NR==3 {printf("%.0f\n",$3*10/7)}' /proc/net/wireless 2>/dev/null)
(( WIFI_Q < 0 )) && WIFI_Q=0; (( WIFI_Q > 100 )) && WIFI_Q=100
if (( CONNECTED == 1 )); then
  if (( WIFI_Q > 75 )); then w="${bright_blue}   ${RESET}"
  elif (( WIFI_Q > 50 )); then w="${bright_blue}   ${RESET}${dark0_soft}${RESET}"
  elif (( WIFI_Q > 25 )); then w="${bright_blue}  ${RESET}${dark0_soft} ${RESET}"
  elif (( WIFI_Q > 0 )); then w="${bright_blue} ${RESET}${dark0_soft}  ${RESET}"
  else w="${dark0_soft}   ${RESET}"; fi
else w="${dark0_soft}   ${RESET}"; fi
echo "$w"
