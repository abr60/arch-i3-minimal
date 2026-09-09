#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/colors.sh"
paused=$(dunstctl is-paused 2>/dev/null)
if [[ $paused == "true" ]]; then echo "${faded_red}${RESET}"; else echo "${faded_green}${RESET}"; fi
