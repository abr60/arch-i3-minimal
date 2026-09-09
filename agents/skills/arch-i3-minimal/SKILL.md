---
name: arch-i3-minimal
description: >
  REQUIRED for customization of this i3 desktop (ThinkPad T14 Gen2i / Intel Xe).
  Use when editing ~/.config/i3/, ~/.config/polybar/, ~/.config/rofi/,
  ~/.config/alacritty/, ~/.config/dunst/, ~/.Xresources, or running
  install.sh / setup.sh / update.sh. Triggers: i3, polybar, rofi, alacritty,
  dunst, keybinds, gaps, bar modules, archinstall, agentic workflow (Super+A).
---

# arch-i3-minimal Skill

Minimal Arch + i3 (X11) — clean monochrome, no compositor, idle ~70-90 MB.
ThinkPad T14 Gen2i, i5-1145G7 / Iris Xe (i915), 15GB RAM, UEFI.

## When This Skill MUST Be Used

**ALWAYS invoke this skill for:**

- Editing ANY file in `~/.config/i3/` (keybinds, gaps, colors, autostart)
- Editing `~/.config/polybar/` (bar layout, modules, colors)
- Editing `~/.config/rofi/` or `~/.config/rofi/menu.sh` (launcher + central menu + webapps)
- Editing `~/.config/alacritty/`, `~/.config/dunst/`, `~/.Xresources`, `~/.xinitrc`
- Running `install.sh`, `setup.sh`, `update.sh`, or touching `install/` scripts
- Agentic workflow: default agent (`arch-default-agent`), launching agent (`arch-agent`, Super+A)

**If you're about to edit a dotfile in ~/.config/ on this system, STOP and use this skill first.**

## Topic Guides

Deeper instructions live next to this file — read the matching guide before starting:

- [`i3.md`](i3.md) — keybinds, workspaces, gaps, autostart, media keys
- [`polybar.md`](polybar.md) — bar layout, modules, colors, scripts
- [`rofi.md`](rofi.md) — launcher, menu (`menu.sh`), webapps, Archer theme
- [`install.md`](install.md) — archinstall choices, packages, `install/` split, setup/update
- [`troubleshooting.md`](troubleshooting.md) — black screen, audio, wifi, bar

## Critical Safety Rules

The installed system owns `/usr/share/`, not this repo. Never edit `/usr/share/` for this dotfile; read it only for reference.

**Always edit in the repo, then re-link:**

```bash
# 1. Read current repo file
cat ~/arch-i3-minimal/.config/i3/config

# 2. Edit in repo (not in ~/.config/ directly)
# 3. Re-link
~/arch-i3-minimal/install/config/dotfiles.sh   # or ./setup.sh
i3-msg reload                                  # i3 picks up config
~/.config/polybar/launch.sh                    # polybar reload
xrdb -merge ~/.Xresources                      # Xresources
```

Reset: `install/config/dotfiles.sh` re-symlinks everything (FORCE overwrites `~/.config`).

## System Architecture

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **Arch + X11** | Base OS | `~/.Xresources`, `~/.xinitrc` |
| **i3** | Tiling WM (gaps 4px in-tree, >=4.22) | `~/.config/i3/config` |
| **polybar** | Bar (Gruvbox warm, RobotoMono 11) | `~/.config/polybar/config.ini` + `colors.ini`/`modules.ini` |
| **rofi** | Launcher + menu | `~/.config/rofi/config.rasi` + `menu.sh` + `scripts/` |
| **alacritty** | Terminal | `~/.config/alacritty/alacritty.toml` |
| **dunst** | Notifications | `~/.config/dunst/dunstrc` |
| **Agent** | Coding agent launcher | `bin/arch-agent`, `bin/arch-default-agent` |

## Configuration Locations (repo → $HOME via symlink)

```
.config/i3/config               → ~/.config/i3/config
.config/polybar/{config,colors,modules}.ini → ~/.config/polybar/
.config/polybar/launch.sh       → autostarted by i3 (exec_always)
.config/rofi/{config.rasi,matugen.rasi,menu.sh} → ~/.config/rofi/
.config/alacritty/alacritty.toml → ~/.config/alacritty/
.config/dunst/dunstrc           → ~/.config/dunst/
.bashrc  .Xresources  .xinitrc   → ~/
install/{packages,services,config/dotfiles}.sh → run by install.sh/setup.sh
agents/skills/arch-i3-minimal/  → symlinked to ~/.agents/skills etc on setup
```

## Agentic Workflow (like Omarchy)

This repo ships a coding-agent workflow modelled on Omarchy (`omarchy-agent`):

- `bin/arch-agent [--inline] [--pick] [--prompt "..."]` — launch default agent. Empty default → `--pick` shows menu. Agents cd to `~/Work` if PWD is `$HOME`. Uses `alacritty --class agent` (app-id `org.arch.agent`) for i3 window rules.
- `bin/arch-default-agent [name]` — get/set default agent. Stores choice in `~/.config/arch-i3-minimal/defaults/agent` (and mirrors `~/.config/omarchy/defaults/agent` for compat). Installs via `mise use -g <pkg>` if missing, then launches presentation terminal.
- Keybinds: **`Super+A`** = `arch-agent` (Omarchy parity), **`Super+Shift+Ctrl+A`** = `arch-agent --pick` (picker).
- Menu: `Setup → Defaults → Agent → {opencode, claude, codex, gemini, copilot, ...}` with `✓` checked.
- Skills: repo `agents/skills/arch-i3-minimal/` is symlinked on `setup.sh` to `~/.agents/skills/`, `~/.claude/skills/`, `~/.codex/skills/`, `~/.pi/agent/skills/`, `~/.hermes/skills/` (Omarchy migration pattern). Agents auto-load `SKILL.md` when relevant.

Default agent candidates (same as Omarchy): `opencode`, `claude`, `codex`, `gemini`, `copilot`, `crush`, `cursor-agent`, `muse`, `pi`, `omp`, `grok`, `hermes`, `openclaw`.

## Decision Framework

1. **Is it an agent launch/default?** Use `arch-agent` / `arch-default-agent`
2. **Is it a config edit?** Edit in repo `~/.config/*`, never `/usr/share/`; re-link + reload
3. **Is it a bar/module?** See `polybar.md`; add module → add to `modules-right` → relaunch
4. **Is it a package?** Add to `install/packages.sh` (single source of truth)
5. **Is it a new keybind?** See `i3.md`; add `bindsym` → `i3-msg reload` → document in `i3.md`
6. **Is install broken?** See `troubleshooting.md`, then `install.md`
