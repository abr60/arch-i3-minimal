# TROUBLESHOOT — common issues, ThinkPad T14 specific

## Black screen after startx
- Check `.xinitrc` is symlinked: `ls -l ~/.xinitrc`. Re-run `./setup.sh`.
- Check i3 installed: `pacman -Q i3-wm`. If not, run `./install.sh`.
- X log: `cat ~/.local/share/xorg/Xorg.0.log | tail -30`.

## No audio
- `systemctl --user status pipewire wireplumber` — both must be active.
- `pamixer --get-volume` — if "no device", reboot after install (PipeWire needs session restart).
- Fn mute: mic mute uses `--default-source`, needs a mic present.

## No WiFi / no tray icon
- `sudo systemctl enable --now NetworkManager`.
- nm-applet needs a tray: polybar `tray-position = right` is set. If missing, run `nm-applet --indicator &` manually.

## Brightness keys do nothing
- `brightnessctl s` — should list intel_backlight. If empty, check /sys/class/backlight/.
- User must be in `video` group on some kernels: `sudo usermod -aG video $USER`, re-login.

## Battery module shows nothing
- Polybar expects BAT0/AC. Verify: `ls /sys/class/power_supply/`. T14 Gen2i uses BAT0 — if yours differs, edit config.ini.

## Polybar blank / missing bar
- `~/.config/polybar/launch.sh` manually, watch errors (usually font missing: install `ttf-jetbrains-mono-nerd`).
- Monitor fallback is eDP-1. External monitor only? Set `monitor-fallback` or `monitor = HDMI-1` in config.ini.

## Rofi looks broken
- Font missing (same nerd-fonts package). `fc-list | grep -i jetbrains`.

## Glyphs / icons as boxes
- Install nerd font + reboot or `fc-cache -fv`.
