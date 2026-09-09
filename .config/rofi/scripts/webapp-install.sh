#!/bin/bash
# webapp-install.sh — compat wrapper → bin/arch-webapp install
exec arch-webapp install "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-webapp" install "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-webapp" install "$@"
