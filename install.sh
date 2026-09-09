#!/bin/bash
# arch-i3-minimal install.sh — run AFTER fresh Arch install
# Usage: ./install.sh
set -e
sudo pacman -Syu --needed \
  i3-wm i3lock polybar \
  alacritty rofi dunst \
  nnn mpv maim feh \
  brightnessctl playerctl pamixer \
  network-manager-applet \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji \
  pipewire pipewire-pulse pipewire-alsa wireplumber \
  networkmanager xorg-xinit xorg-xset xorg-server \
  firefox thunar pulseaudio-alsa 2>/dev/null || \
sudo pacman -Syu --needed \
  i3-wm i3lock polybar \
  alacritty rofi dunst \
  nnn mpv maim feh \
  brightnessctl playerctl pamixer \
  network-manager-applet \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji \
  pipewire pipewire-pulse pipewire-alsa wireplumber \
  networkmanager xorg-xinit xorg-server firefox

sudo systemctl enable NetworkManager
echo "Done. Now run ./setup.sh then 'startx'."
