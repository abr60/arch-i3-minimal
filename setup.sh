#!/bin/bash
# arch-i3-minimal setup.sh — symlink dotfiles to $HOME
# Usage: ./setup.sh (run from repo root)
set -e
REPO="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.config ~/Pictures
ln -sfn "$REPO/.config/i3" ~/.config/i3
ln -sfn "$REPO/.config/polybar" ~/.config/polybar
ln -sfn "$REPO/.config/alacritty" ~/.config/alacritty
ln -sfn "$REPO/.config/rofi" ~/.config/rofi
ln -sfn "$REPO/.config/dunst" ~/.config/dunst
ln -sfn "$REPO/.bashrc" ~/.bashrc
ln -sfn "$REPO/.Xresources" ~/.Xresources
ln -sfn "$REPO/.xinitrc" ~/.xinitrc
chmod +x ~/.config/polybar/launch.sh ~/.config/i3/powermenu.sh
mkdir -p ~/Pictures
echo "Linked. Run 'startx' to launch i3."
