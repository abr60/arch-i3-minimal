#!/bin/bash
# setup-howdy.sh — compat wrapper → bin/arch-howdy
exec arch-howdy "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-howdy" "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-howdy" "$@"
