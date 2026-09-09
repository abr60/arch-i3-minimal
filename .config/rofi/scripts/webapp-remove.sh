#!/bin/bash
# webapp-remove.sh — compat wrapper → bin/arch-webapp remove
exec arch-webapp remove "$@" 2>/dev/null || exec "$HOME/arch-i3-minimal/bin/arch-webapp" remove "$@" || exec "$(cd "$(dirname "$0")/../../.." && pwd)/bin/arch-webapp" remove "$@"
