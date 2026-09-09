# EXTENSIONS — how to add things without breaking minimal

## New polybar module
1. Append `[module/name]` section to `.config/polybar/config.ini`.
2. Add `name` to `modules-right` (or left) in `[bar/main]`.
3. Run `~/.config/polybar/launch.sh` to reload.
4. If module needs a binary/script, add its package to install.sh.

## New i3 keybind
1. Add `bindsym $mod+X exec ...` to `.config/i3/config`.
2. `i3-msg reload`.
3. Document it in docs/KEYBINDS.md.

## New workspace
Workspaces 1-9 exist. To add 10: duplicate the 9 lines for 10 in i3 config + add `ws-icon-9` in polybar i3 module.

## Rofi theming
`.config/rofi/config.rasi` is minimal on purpose. Keep dark palette (#1a1a1a/#2a2a2a/#d4d4d4). Test with `rofi -show drun`.

## Wallpaper
Drop image at `~/.wallpaper` — i3 autostart picks it up via feh. No file = solid #1a1a1a.

## Rules
- No new daemon without RAM justification in docs/PACKAGES.md.
- No compositor. No display manager. No zsh frameworks.
