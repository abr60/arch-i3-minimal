#!/bin/bash
# install/packages.sh — pacman packages for arch-i3-minimal
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib/helpers.sh"
log "Validating package names"
BAD=$(for p in \
  i3-wm i3lock polybar alacritty rofi rofi-calc rofi-emoji dunst \
  nnn mpv maim feh fastfetch fzf \
  brightnessctl playerctl pamixer pavucontrol \
  xclip xdotool udiskie redshift slop \
  clipmenu xss-lock tesseract tesseract-data-eng ffmpeg xcolor \
  bluez bluez-utils pacman-contrib libnotify curl jq \
  network-manager-applet \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji noto-fonts-cjk \
  pipewire pipewire-pulse pipewire-alsa wireplumber \
  networkmanager xorg-xinit xorg-xset xorg-server \
  power-profiles-daemon zram-generator \
  firefox thunar; do
  pacman -Si "$p" >/dev/null 2>&1 || echo "$p"
done)
if [[ -n $BAD ]]; then
  echo "BAD packages (not found in repos): $BAD" >&2
  exit 1
fi
log "Installing packages (pacman -Syu)"
sudo pacman -Syu --needed \
  i3-wm i3lock polybar \
  alacritty rofi rofi-calc rofi-emoji dunst \
  nnn mpv maim feh fastfetch fzf \
  brightnessctl playerctl pamixer pavucontrol \
  xclip xdotool udiskie redshift slop \
  clipmenu xss-lock tesseract tesseract-data-eng ffmpeg xcolor \
  bluez bluez-utils pacman-contrib libnotify curl jq \
  network-manager-applet \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji noto-fonts-cjk \
  pipewire pipewire-pulse pipewire-alsa wireplumber \
  networkmanager xorg-xinit xorg-xset xorg-server \
  power-profiles-daemon zram-generator \
  firefox thunar
ok "packages installed"
