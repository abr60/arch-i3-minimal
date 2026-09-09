#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/colors.sh"
# generic bluetooth indicator: any connected device?
if bluetoothctl devices Connected 2>/dev/null | grep -q "Device"; then
  echo "${faded_green}${RESET}"
else
  # fallback: check bluetooth power
  if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then echo "${dark0_soft}${RESET}"; else echo "${dark0_soft}${RESET}"; fi
fi
