#!/bin/bash
# arch-i3-minimal setup.sh — symlink dotfiles (spice pattern)
# Usage: ./setup.sh
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$DIR/install/config/dotfiles.sh"
