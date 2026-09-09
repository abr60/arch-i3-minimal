#!/bin/bash
# update.sh — wrapper for backward compat (polybar click, skill docs, etc.)
# Full bin implementation is bin/arch-update (Omarchy parity); this delegates to it.
set -e
exec "$(cd "$(dirname "$0")" && pwd)/bin/arch-update" all "$@"
