#!/bin/bash
# pkg-orphans.sh — fuzzy TUI for removing orphaned deps (omarchy-update-orphan-pkgs port)
ORPHANS=$(pacman -Qtdq 2>/dev/null)
[[ -z $ORPHANS ]] && { echo "No orphans."; sleep 2; exit 0; }
PKGS=$(printf '%s\n' "$ORPHANS" | fzf --multi --preview 'pacman -Qi {1}' --color 'pointer:red,marker:red')
if [[ -n $PKGS ]]; then
  sudo -v
  echo "$PKGS" | tr '\n' ' ' | xargs sudo pacman -Rns --noconfirm
  notify-send 'Orphans' 'Done' 2>/dev/null
  echo; read -rp 'Done — press any key ' -n1
fi
