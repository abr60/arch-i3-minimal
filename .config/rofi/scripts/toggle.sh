#!/bin/bash
# toggle.sh — compat wrapper → bin/arch-toggle (see bin/arch-toggle for impl)
exec arch-toggle "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-toggle" "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-toggle" "$@"
