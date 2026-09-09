#!/bin/bash
# pkg-install.sh — compat wrapper → bin/arch-pkg-install
exec arch-pkg-install "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-pkg-install" "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-pkg-install" "$@"
