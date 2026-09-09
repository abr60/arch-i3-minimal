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
├── Install     → Package (pacman -S), Howdy (AUR), Nerd fonts
├── Learn       → Keybindings, Arch Wiki
├── Update      → update.sh: pacman -Syu + git pull + re-link
│                 (OVERWRITES local changes in ~/.config)
└── About       → fastfetch
```

Related scripts in `.config/rofi/scripts/`:
capture.sh (ocr/color/record/stop), bluetooth.sh, reminder.sh (set/show/clear),
setup-howdy.sh (install/status). Polybar side: `UPD N` module (click = update.sh),
weather module (click = wttr.in).
