# Polybar

Repo: `.config/polybar/` → `~/.config/polybar/`. Gruvbox warm (Archer-inspired) with `colors.ini`.

## Layout

`config.ini` `[bar/main]`:
- `modules-left = i3`
- `modules-center = custom_time`
- `modules-right = updates healthbar cpu memory pulseaudio backlight battery net_indicator dunst_indicator bluetooth_speaker weather date`
- Fonts: `RobotoMono Nerd Font 11` + `feather` + `Pragmata Pro` (like dotfiles-master, height 32 → 42 if you want thicker).
- Tray: `right`, `wm-restack = i3`, `fixed-center = true`.

Colors in `colors.ini`: `dark0_hard #121715`, `light0_soft #e8d499`, `faded_*` / `bright_*` Gruvbox palette.

## Modules / Scripts

`scripts/` (all `chmod +x`):

| Module | Script |
|--------|--------|
| `updates` | `updates.sh` — `checkupdates | wc -l` → `UPD N` / `OK`, click → `update.sh` |
| `weather` | `weather.sh` — `wttr.in` cached 30min |
| `custom_time` | `custom_time.sh` — weekday + time (yellow) + date |
| `healthbar` | `healthbar.sh` — battery % + AC icon with color (green>25 / yellow>10 / red) |
| `net_indicator` / `wifibar` / `netspeed` | wifi/vpn, signal bars, KB/s |
| `dunst_indicator` / `bluetooth_speaker` | paused? / connected? |

All scripts `source colors.sh` for `%{F#...}` polybar tags.

## Adding a Module

1. Append `[module/name]` to `config.ini` (or `modules.ini` / `custom_modules.ini` if you keep split files).
2. Add `name` to `modules-right` (or left).
3. `~/.config/polybar/launch.sh` to reload.
4. If it needs a binary, add package to `install/packages.sh`.

Monitor fallback is `eDP-1`. External-only? Set `monitor = HDMI-1` or `monitor-fallback`.
