#!/bin/bash
# capture.sh — compat wrapper → bin/arch-capture
exec arch-capture "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-capture" "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-capture" "$@"
