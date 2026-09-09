# PACKAGES — every package, why it exists, approx idle RAM

## WM / bar / desktop
- i3-wm (~30MB) — tiling WM, gaps built in since 4.22
- i3lock (~2MB) — lock screen
- polybar (~12MB) — status bar
- dunst (~4MB) — notifications
- feh (~2MB) — wallpaper setter (falls back to xsetroot solid if no ~/.wallpaper)
- xorg-server, xorg-xinit, xorg-xset — X stack + startx + key repeat

## Apps
- alacritty (~8MB) — GPU terminal
- rofi (~8MB) — launcher
- nnn (~2MB) — terminal file manager
- mpv (~15MB when playing) — media player
- firefox — browser (heaviest item, user choice)
- thunar — optional GUI file manager

## Hardware / media plumbing (ThinkPad T14)
- brightnessctl — Fn brightness (intel_backlight)
- playerctl — Fn media keys via MPRIS
- pamixer — Fn volume via PipeWire/Pulse
- pipewire, pipewire-pulse, pipewire-alsa, wireplumber — audio stack
- networkmanager + network-manager-applet (nm-applet tray in polybar)
- maim — screenshots

## Fonts
- ttf-jetbrains-mono-nerd — bar + terminal + rofi + dunst glyphs
- noto-fonts, noto-fonts-emoji — fallback coverage

Total idle (no browser): ~70-90MB. `free -h` after startx to verify.
