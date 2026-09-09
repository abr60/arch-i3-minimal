# Rofi (launcher + menu)

Repo: `.config/rofi/` → `~/.config/rofi/`.

## Theme

`config.rasi` `@import "matugen.rasi"` — Archer compact style (520px, no icons, `surface #16130d`, `primary #efbf6c`), `font JetBrainsMono Nerd Font 11`. Icons disabled via `element-icon { enabled: false; }` for speed.

`matugen.rasi` holds the palette — edit it to re-theme; `config.rasi` holds layout.

## Launcher

`Super+Space` → `rofi -show drun -theme config.rasi` (apps + window + calc + emoji modes).

## Central Menu (`menu.sh`)

Omarchy-menu port, recursive `menu.sh [route]` via `rofi -dmenu`:

`Apps / Learn / Trigger / Toggle / Style / Setup / Install / Remove / Update / About / System`

- **Trigger**: capture (screenshot/region/record/OCR/color), share, hardware/BT, clipboard, nightlight.
- **Toggle**: touchpad / Stay Awake (xss-lock) / bar (polybar) / notifications (dunst) — shows `✓` state.
- **Setup → Defaults → Agent**: picks default coding agent (see SKILL.md), **Security → Howdy** (face unlock).
- **Install/Remove**: fzf TUIs (`scripts/pkg-*.sh` → `alacritty --class pkg`), Howdy, nerdfonts, webapps.
- **System**: lock/suspend/reboot (also `Super+Escape`).

All floating TUIs use `class="pkg"` → i3 floats 900×600 centered.

## Webapps (SSB)

`scripts/webapp-install.sh [name url [icon]]` → `~/.local/share/applications/<name>.desktop` (`Exec` via `webapp-launch.sh --app=<url>`). Auto-fetches icon (`curl` touch-icon), updates desktop DB. `webapp-remove.sh` / `webapp-launch.sh` mirror `omarchy-webapp-*`.

Add via `menu.sh → Install → Web App` or CLI.
