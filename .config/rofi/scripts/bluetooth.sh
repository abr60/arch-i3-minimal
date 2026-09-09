#!/bin/bash
# bluetooth.sh — compat wrapper → bin/arch-bluetooth
exec arch-bluetooth "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-bluetooth" "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-bluetooth" "$@"
