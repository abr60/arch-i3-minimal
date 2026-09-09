# Install / Setup

## Fresh Arch (archinstall)

Boot Arch ISO → `archinstall` — choices in `docs/ARCHINSTALL.md` (source of truth):
Profile **Desktop → None** (X only), filesystem `ext4`, bootloader `systemd-boot`, audio `PipeWire`, network `NetworkManager`, Intel graphics (i915, no extra driver).

Post-reboot:

```bash
sudo pacman -Syu git
git clone https://github.com/abr60/arch-i3-minimal.git ~/arch-i3-minimal
cd ~/arch-i3-minimal
./install.sh
./setup.sh
startx
```

## `install/` (spice pattern)

Thin wrappers `install.sh` / `setup.sh` delegate to `install/`:

- `install/lib/helpers.sh` — `log`/`ok`/`warn`/`die`/`has()`, `REPO_DIR`.
- `install/packages.sh` — `sudo pacman -Syu --needed` full list (i3/polybar/rofi/alacritty/dunst/nnn/mpv/maim/feh/fzf/brightnessctl/playerctl/pamixer/xclip/xdotool/udiskie/redshift/slop/clipmenu/xss-lock/tesseract/ffmpeg/xcolor/bluez/pacman-contrib/libnotify/curl/jq + fonts + pipewire + networkmanager + xorg + firefox/thunar).
- `install/services.sh` — `systemctl enable NetworkManager power-profiles-daemon systemd-oomd bluetooth`.
- `install/config/dotfiles.sh` — symlinks `REPO/.config/*` → `~/.config/`, `.bashrc/.Xresources/.xinitrc` → `~/`, `chmod +x` scripts + `thunar` default via `xdg-mime`; also links `agents/skills/arch-i3-minimal` → `~/.agents/skills` etc.
- `install/config/skills.sh` — agent skill symlinks (Omarchy migrations 1786098807+1787843905 pattern: `~/.agents/skills`, `~/.claude/skills`, `~/.codex/skills`, `~/.pi/agent/skills`, `~/.hermes/skills`).

## Update

`update.sh` (repo root, also Polybar `UPD N` click + `menu.sh → Update`):

`pacman -Syu` (+ `yay -Sua` if present) → `git pull --rebase` → `./setup.sh` (re-symlinks, FORCE overwrites `~/.config`) → `i3-msg restart`.

## Minimal Rule

No compositor, no DM, no zsh framework. Every new package/daemon must justify RAM and be added to `install/packages.sh`.
