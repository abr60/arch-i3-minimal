#!/bin/bash
# pkg-aur-install.sh — fuzzy TUI for AUR packages (omarchy-pkg-aur-install port)
# Bootstraps yay-bin from AUR on first use.
if ! command -v yay >/dev/null; then
  echo "== yay not found — installing yay-bin from AUR =="
  sudo pacman -S --needed --noconfirm base-devel git
  TMP=$(mktemp -d)
  git clone https://aur.archlinux.org/yay-bin.git "$TMP/yay-bin"
  (cd "$TMP/yay-bin" && makepkg -si --noconfirm)
  rm -rf "$TMP"
  command -v yay >/dev/null || { echo "yay install failed"; read -rp 'press any key ' -n1; exit 1; }
fi

FZF_ARGS=(--multi
  --preview 'yay -Siia {1}'
  --preview-label='alt-p: toggle description, alt-b: PKGBUILD, tab: multi-select'
  --preview-label-pos='bottom' --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-b:change-preview:yay -Gpa {1} | tail -n +5'
  --color 'pointer:green,marker:green')
PKGS=$(yay -Slqa | fzf "${FZF_ARGS[@]}")
if [[ -n $PKGS ]]; then
  echo "$PKGS" | sed 's/^/aur\//' | tr '\n' ' ' | xargs yay -S --noconfirm
  notify-send 'AUR' 'Done' 2>/dev/null
  echo; read -rp 'Done — press any key ' -n1
fi
