#!/bin/bash
# pkg-aur-install.sh — compat wrapper → bin/arch-pkg-aur-install
exec arch-pkg-aur-install "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-pkg-aur-install" "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-pkg-aur-install" "$@"
