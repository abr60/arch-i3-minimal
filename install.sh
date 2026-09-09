#!/bin/bash
# arch-i3-minimal install.sh — thin wrapper (spice pattern)
# Usage: ./install.sh
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
"$DIR/install/packages.sh"
"$DIR/install/services.sh"
echo "Done. Now run ./setup.sh then 'startx'."
