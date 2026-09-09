# MENU — central rofi menu (Omarchy-menu port)

Open with **Super+Alt+Space**. Recursive routes: `menu.sh [route]`.

```
Menu
├── Apps        → rofi drun launcher
├── Learn       → Keybindings, i3 Manual, Arch Wiki, Bash/Plybar/Rofi docs
├── Trigger     → Emoji, Reminder (set/show/clear), Capture (screenshot/region/record/OCR/color/QR),
│                 Share (clipboard/file/folder/localsend), Toggle…, Hardware (touchpad/touchscreen/display/BT),
│                 Speed Test, Clipboard history, Color picker, OCR
├── Toggle      → Touchpad / Stay Awake (xss-lock) / Menu Bar (polybar) / Notifications (dunst) / Nightlight / Gaps [✓]
├── Style       → Background (feh picker ~/Pictures/wallpapers), Bar position Top/Bottom,
│                 Transparency, Toggle gaps, Font, Screensaver text, Reload i3/polybar
├── Setup       → Monitors, Keybindings, Network/DNS (nmtui, 1.1.1.1/8.8.8.8), Defaults (browser/editor/terminal),
│                 Security (Howdy face unlock / fingerprint / SSHD / passwordless sudo / Fido2),
│                 Edit i3/polybar/menu/rofi theme
├── Install     → Package (fzf), AUR package (yay auto-bootstrap), Web App (SSB), TUI, Nerd fonts,
│                 Service (1Password/Dropbox/Spotify/Signal/Tailscale), Browser (Chrome/Brave/Edge/Firefox/Zen),
│                 Editor (VSCode/Cursor/Zed…), Terminal (Alacritty/Foot/Kitty/Ghostty),
│                 AI (Ollama/LM Studio/Dictation), Gaming (Steam/RetroArch/Lutris…), Development (Rails/Docker/Go…)
├── Remove      → Package, Orphaned packages, Web App, TUI, Theme, Browser, Service, Gaming
├── Update      → System (pacman+yay), Dotfiles (git pull), Firmware, Timezone/Time, Password
├── About       → fastfetch + repo link
└── System      → Lock / Suspend / Hibernate / Logout / Reboot / Shutdown (also Super+Escape)
```

Related scripts in `.config/rofi/scripts/`:
capture.sh (ocr/color/record/stop), bluetooth.sh, reminder.sh, setup-howdy.sh, toggle.sh,
pkg-install.sh / pkg-aur-install.sh / pkg-remove.sh / pkg-orphans.sh (fzf TUIs),
webapp-install.sh / webapp-launch.sh / webapp-remove.sh (SSB .desktop).
Thunar default file manager (Super+Shift+F, xdg-mime in setup.sh).
