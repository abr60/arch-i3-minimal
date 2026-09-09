#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/colors.sh"
WEEKDAY=$(date +%A); TIME=$(date +%H:%M:%S); DATE=$(date +"%e %b %Y")
echo "${light0_soft} ${WEEKDAY} ${faded_yellow}${TIME}${light0_soft} ${DATE} ${RESET}"
