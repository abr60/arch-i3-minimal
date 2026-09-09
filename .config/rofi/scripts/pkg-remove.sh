#!/bin/bash
# pkg-remove.sh — fuzzy TUI for removing installed packages (omarchy-pkg-remove port)
FZF_ARGS=(--multi
  --preview 'pacman -Qi {1}'
  --preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select'
  --preview-label-pos='bottom' --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --color 'pointer:red,marker:red')
PKGS=$(pacman -Qqe | fzf "${FZF_ARGS[@]}")
if [[ -n $PKGS ]]; then
  sudo -v
  ( while :; do sudo -n true 2>/dev/null; sleep 60; done ) & KA=$!
  echo "$PKGS" | tr '\n' ' ' | xargs sudo pacman -Rns --noconfirm
  kill "$KA" 2>/dev/null
  notify-send 'Packages' 'Done' 2>/dev/null
  echo; read -rp 'Done — press any key ' -n1
fi
