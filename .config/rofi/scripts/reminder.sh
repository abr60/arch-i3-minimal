#!/bin/bash
# reminder.sh — compat wrapper → bin/arch-reminder
exec arch-reminder "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-reminder" "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-reminder" "$@"
