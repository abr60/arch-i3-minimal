#!/bin/bash
# updates.sh — polybar update counter (Omarchy system-update widget port)
# Prints pending pacman update count; click launches update.sh in a terminal.
command -v checkupdates >/dev/null || exit 0
N=$(checkupdates 2>/dev/null | wc -l)
if (( N > 0 )); then echo "UPD $N"; else echo "OK"; fi
