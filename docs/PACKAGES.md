# PACKAGES — every package, why it exists, approx idle RAM

## WM / bar / desktop
- i3-wm (~30MB) — tiling WM, gaps built in since 4.22
- i3lock (~2MB) — lock screen (xss-lock auto-locks 5min + suspend)
- polybar (~12MB) — Gruvbox warm bar (#121715 bg, #e8d499 fg, RobotoMono 11) with i3 / custom_time / updates / healthbar / cpu / mem / vol / brightness / battery / net / dunst / bluetooth / weather
- dunst (~4MB) — notifications
- feh (~2MB) — wallpaper
- xorg-server, xorg-xinit, xorg-xset — X stack + startx + key repeat

## Apps
- alacritty (~8MB) — GPU terminal
- rofi (~8MB) — launcher + calc + emoji (Archer/matugen theme: #16130d surface, #efbf6c primary, 520px)
- clipmenu + xss-lock — clipboard history + idle lock
- nnn, mpv, maim, slop, ffmpeg, tesseract, xcolor — utils / capture / OCR / record
- firefox — browser; thunar — file manager

## Hardware / media plumbing (ThinkPad T14)
- brightnessctl, playerctl, pamixer, pavucontrol — Fn keys
- pipewire, pipewire-pulse, pipewire-alsa, wireplumber — audio
- networkmanager + network-manager-applet, bluez/bluez-utils — net / BT
- power-profiles-daemon, systemd-oomd, zram-generator — power/oom/swap

## Fonts
- ttf-jetbrains-mono-nerd, noto-fonts, noto-fonts-emoji, noto-fonts-cjk — bar/terminal/rofi + fallback

Total idle (no browser): ~70-90MB. `free -h` after startx to verify.

Installer is split: `install/` (lib/helpers.sh, packages.sh, services.sh, config/dotfiles.sh) — thin `install.sh`/`setup.sh` wrappers (spice pattern).
