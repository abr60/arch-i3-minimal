#!/bin/bash
# webapp-launch.sh — compat wrapper → bin/arch-webapp launch
exec arch-webapp launch "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-webapp" launch "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-webapp" launch "$@"
