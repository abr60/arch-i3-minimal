#!/bin/bash
# pkg-remove.sh — compat wrapper → bin/arch-pkg-remove
exec arch-pkg-remove "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-pkg-remove" "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-pkg-remove" "$@"
