# Troubleshooting

## Black screen after `startx`

- `ls -l ~/.xinitrc` must be symlink → `~/arch-i3-minimal/.xinitrc`; re-run `~/arch-i3-minimal/install/config/dotfiles.sh`.
- `pacman -Q i3-wm` — if missing, `./install.sh`.
- `cat ~/.local/share/xorg/Xorg.0.log | tail -30`.

## No audio / mic mute

- `systemctl --user status pipewire wireplumber` — both active.
- `pamixer --get-volume` — "no device" → reboot after install (PipeWire needs session restart).

## No WiFi / no tray

- `sudo systemctl enable --now NetworkManager`; tray needs `tray-position = right` in `config.ini`. Fallback: `nm-applet --indicator &`.

## Brightness / Battery

- `brightnessctl s` should list `intel_backlight`; check `/sys/class/backlight/` and `video` group.
- Battery module expects `BAT0/AC` — verify `ls /sys/class/power_supply/`; T14 Gen2i uses `BAT0`.

## Polybar blank

- Run `~/.config/polybar/launch.sh` manually — usually missing `ttf-jetbrains-mono-nerd` → `sudo pacman -S ttf-jetbrains-mono-nerd; fc-cache -fv`.
- Monitor fallback is `eDP-1` — external-only? Set `monitor = HDMI-1`.

## Rofi / Glyphs as boxes

- Same nerd-font fix + `fc-list | grep -i jetbrains`.
