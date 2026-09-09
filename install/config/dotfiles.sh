#!/bin/bash
# install/config/dotfiles.sh — symlink repo configs → $HOME
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/../lib/helpers.sh"
REPO="$(cd "$DIR/../.." && pwd)"
log "Linking dotfiles → \$HOME"
mkdir -p ~/.config ~/Pictures
ln -sfn "$REPO/.config/i3" ~/.config/i3
ln -sfn "$REPO/.config/polybar" ~/.config/polybar
ln -sfn "$REPO/.config/alacritty" ~/.config/alacritty
ln -sfn "$REPO/.config/rofi" ~/.config/rofi
ln -sfn "$REPO/.config/dunst" ~/.config/dunst
ln -sfn "$REPO/.bashrc" ~/.bashrc
ln -sfn "$REPO/.bash_profile" ~/.bash_profile
ln -sfn "$REPO/.Xresources" ~/.Xresources
ln -sfn "$REPO/.xinitrc" ~/.xinitrc
chmod +x ~/.config/polybar/launch.sh ~/.config/rofi/menu.sh 2>/dev/null || true
chmod +x ~/.config/rofi/scripts/*.sh ~/.config/polybar/scripts/*.sh "$REPO/update.sh" 2>/dev/null || true
if [[ -f /usr/share/applications/thunar.desktop ]]; then
  xdg-mime default thunar.desktop inode/directory application/x-gnome-saved-search 2>/dev/null || true
fi
# bin wrappers → ~/.local/bin (for arch-agent etc)
mkdir -p ~/.local/bin
for b in "$REPO/bin"/*; do [[ -f $b ]] && ln -sfn "$b" ~/.local/bin/"$(basename "$b")" && chmod +x "$b"; done
# agent skills → ~/.agents/skills etc (Omarchy pattern)
"$REPO/install/config/skills.sh" 2>/dev/null || true
ok "dotfiles linked — run 'startx' to launch i3"
