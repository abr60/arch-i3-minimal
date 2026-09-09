#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/colors.sh"
PATH_AC="/sys/class/power_supply/AC"
PATH_BAT0="/sys/class/power_supply/BAT0"
PATH_BAT1="/sys/class/power_supply/BAT1"
ac=0; lvl0=0; max0=0; lvl1=0; max1=0
[[ -f $PATH_AC/online ]] && ac=$(cat "$PATH_AC/online")
[[ -f $PATH_BAT0/energy_now ]] && lvl0=$(cat "$PATH_BAT0/energy_now")
[[ -f $PATH_BAT0/energy_full ]] && max0=$(cat "$PATH_BAT0/energy_full")
[[ -f $PATH_BAT1/energy_now ]] && lvl1=$(cat "$PATH_BAT1/energy_now")
[[ -f $PATH_BAT1/energy_full ]] && max1=$(cat "$PATH_BAT1/energy_full")
# fallback to capacity if energy not present
if (( max0 == 0 )); then
  [[ -f $PATH_BAT0/capacity ]] && lvl0=$(cat "$PATH_BAT0/capacity") && max0=100
  [[ -f $PATH_BAT1/capacity ]] && lvl1=$(cat "$PATH_BAT1/capacity") && max1=100
fi
total=$((lvl0 + lvl1)); cap=$((max0 + max1))
(( cap == 0 )) && echo "${dark0_soft}BAT --${RESET}" && exit 0
pct=$(( total * 100 / cap ))
# clamp
(( pct > 100 )) && pct=100; (( pct < 0 )) && pct=0
if (( pct > 25 )); then col="$faded_green"; elif (( pct > 10 )); then col="$faded_yellow"; else col="$faded_red"; fi
if (( ac == 1 )); then icon=""; else icon=""; fi
# if no nerd icon renders, fallback to text
echo "${col}${icon}${RESET} ${pct}%"
