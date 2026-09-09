#!/bin/bash
# arch-i3-minimal install.sh — run AFTER fresh Arch install
# Usage: ./install.sh
set -e
sudo pacman -Syu --needed \
  i3-wm i3lock polybar \
  alacritty rofi rofi-calc rofi-emoji dunst \
  nnn mpv maim feh fastfetch \
  brightnessctl playerctl pamixer pavucontrol \
  xclip xdotool udiskie redshift \
  network-manager-applet \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji noto-fonts-cjk \
  pipewire pipewire-pulse pipewire-alsa wireplumber \
  networkmanager xorg-xinit xorg-xset xorg-server \
  power-profiles-daemon zram-generator \
  firefox thunar adwaita-dark

sudo systemctl enable NetworkManager power-profiles-daemon systemd-oomd
echo "Done. Now run ./setup.sh then 'startx'."
