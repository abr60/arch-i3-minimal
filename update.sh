#!/bin/bash
# update.sh — Omarchy-style one-shot update: system packages + re-sync dotfiles.
# CAUTION: re-running setup overwrites local changes under ~/.config (symlinks
# are force-replaced). Run from repo root or anywhere.
set -e
REPO="$HOME/arch-i3-minimal"
[[ -d $REPO ]] || REPO="$(cd "$(dirname "$0")" && pwd)"

echo "== 1/2 system packages =="
sudo pacman -Syu --noconfirm

echo "== 2/2 dotfiles (git pull + re-link, overwrites local changes) =="
cd "$REPO"
git pull --rebase 2>/dev/null || echo "(no remote / offline — keeping local copy)"
./setup.sh
i3-msg restart 2>/dev/null || true
echo "Done."
