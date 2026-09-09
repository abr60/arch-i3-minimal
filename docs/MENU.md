# MENU — central rofi menu (Omarchy-menu port)

Open with **Super+Alt+Space**. Recursive routes: `menu.sh [route]`.

```
Menu
├── Apps        → rofi drun launcher
├── Trigger     → Screenshot full / region, Record screen, Stop recording,
│                 OCR text, Color picker, Emoji, Calculator, Reminder,
│                 Clipboard history, Nightlight toggle, Bluetooth
├── System      → Lock / Suspend / Logout / Reboot / Shutdown
│                 (also direct: Super+Escape)
├── Style       → Background (feh picker from ~/Pictures/wallpapers),
│                 Toggle gaps, Reload i3
├── Setup       → Security ▸ Howdy face unlock (AUR install + i3lock PAM,
│                 optional, never installed by default)
│                 Security ▸ Passwordless sudo (wheel NOPASSWD)
│                 Edit i3 config / Edit menu
├── Install     → Package (fzf TUI), AUR package (yay, auto-bootstrapped),
│                 Howdy (AUR), Nerd fonts
├── Remove      → Package (fzf explicit-only), Orphaned packages
├── Learn       → Keybindings, Arch Wiki
├── Update      → update.sh: pacman -Syu (+ yay -Sua) + git pull + re-link
│                 (OVERWRITES local changes in ~/.config)
└── About       → fastfetch
```

Related scripts in `.config/rofi/scripts/`:
capture.sh (ocr/color/record/stop), bluetooth.sh, reminder.sh (set/show/clear),
setup-howdy.sh (install/status), toggle.sh (touchpad/idle/bar/notify/state),
pkg-install.sh, pkg-aur-install.sh, pkg-remove.sh, pkg-orphans.sh (fzf TUIs).
Thunar is the default file manager (Super+Shift+F, xdg-mime default in setup.sh).
