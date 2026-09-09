#!/bin/bash
# install/services.sh — enable system services
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib/helpers.sh"
log "Enabling services"
sudo systemctl enable NetworkManager power-profiles-daemon systemd-oomd bluetooth 2>/dev/null || true
ok "services enabled"
