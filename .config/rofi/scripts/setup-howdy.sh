#!/bin/bash
# setup-howdy.sh — install + configure howdy face unlock for i3lock (OPTIONAL)
# Mirrors Omarchy setup > security. Howdy is AUR-only and never installed by default.
# Usage: setup-howdy.sh [install|status]
set -e

if [[ $1 == install ]] || ! command -v howdy >/dev/null; then
  echo "== howdy is AUR-only. Installing (needs base-devel) =="
  sudo pacman -S --needed base-devel cmake python-pip
  TMP=$(mktemp -d)
  git clone https://aur.archlinux.org/howdy.git "$TMP/howdy"
  (cd "$TMP/howdy" && makepkg -si --noconfirm)
  rm -rf "$TMP"
  echo "== installed. Now configure: =="
fi

if ! command -v howdy >/dev/null; then echo "howdy not found, abort"; exit 1; fi

echo "== enable IR camera + add howdy to i3lock PAM =="
sudo python -m pip install --break-system-packages dlib 2>/dev/null || true
if ! grep -q howdy /etc/pam.d/i3lock 2>/dev/null; then
  echo "auth sufficient pam_python.so /lib/security/howdy/pam.py" | sudo tee -a /etc/pam.d/i3lock
fi
echo "== enroll your face (follow prompts) =="
sudo howdy add
echo "== done. Lock (Super+L) and look at the camera to test. =="
howdy status 2>/dev/null || true
