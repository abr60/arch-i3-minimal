#!/bin/bash
# pkg-orphans.sh — compat wrapper → bin/arch-pkg-orphans
exec arch-pkg-orphans "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-pkg-orphans" "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-pkg-orphans" "$@"
