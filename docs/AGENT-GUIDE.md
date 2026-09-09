# AGENT-GUIDE — master reference for AI agents working on arch-i3-minimal

Target machine: Lenovo ThinkPad T14 Gen 2i (Intel i5-1145G7, Iris Xe, 15GB RAM, UEFI).
Goal: clean minimal i3 on X11, monochrome dark, idle ~70-90 MB, no compositor.

## Repo layout
```
.config/i3/config              # WM: gaps, colors, keybinds, autostart, media keys
.config/polybar/config.ini     # bar: modules-left/center/right, colors, fonts
.config/polybar/launch.sh      # killall + relaunch polybar (exec'd by i3)
.config/alacritty/alacritty.toml
.config/rofi/config.rasi
.config/dunst/dunstrc
.bashrc  .Xresources  .xinitrc # shell, X cursor/DPI, startx entrypoint
install.sh                     # pacman packages (single source of truth)
setup.sh                       # symlinks repo -> $HOME (idempotent)
docs/                          # agent skills (this folder)
opencode-session-export.md     # original design conversation, read-only history
```

## Modification rules
1. Edit files in the repo, never in $HOME directly. Then re-run `./setup.sh` (symlinks) or changes apply automatically since setup.sh symlinks.
2. `install.sh` is the package source of truth. If a config references a binary (pamixer, brightnessctl, playerctl, maim, feh), that package MUST be in install.sh.
3. Keep it minimal: no compositor, no animations, no extra daemons. Every addition must justify RAM cost.
4. i3 version on Arch (>= 4.22) has gaps built in — package is `i3-wm`, no `i3-gaps` fork needed.
5. After editing i3 config: `i3-msg reload`. After polybar config: `~/.config/polybar/launch.sh`. After .Xresources: `xrdb -merge ~/.Xresources`.

## Component interaction map
- `.xinitrc` -> `exec i3` -> i3 reads `.config/i3/config`
- i3 autostart: polybar launch.sh, feh wallpaper (fallback xsetroot solid), dunst, nm-applet
- i3bar disabled (`mode invisible`); polybar is the only bar
- Volume keys -> pamixer (PipeWire compat via pipewire-pulse). Brightness -> brightnessctl (intel_backlight). Media -> playerctl (mpv/firefox MPRIS).
- Polybar `internal/backlight card = intel_backlight`, `internal/battery BAT0` — ThinkPad-specific, don't rename without checking /sys/class.

## Fonts
JetBrainsMono Nerd Font everywhere (bar + terminal + rofi + dunst). Package `ttf-jetbrains-mono-nerd` in install.sh. If glyphs missing, that's the first thing to check.

## What NOT to do
- Don't add picom/compton (breaks the no-compositor rule; clean minimal needs none).
- Don't add display managers (GDM/SDDM/LightDM) — `startx` via .xinitrc is intentional.
- Don't add zsh/oh-my-zsh unless user asks — bash is the default, keep RAM low.
- Don't touch nvme0n1 in any install docs — that's the Omarchy drive.
