# arch-i3-minimal

Lightweight Arch Linux + i3 setup. Clean minimal, monochrome dark.
Target: ThinkPad T14 Gen2i (Intel i5-1145G7 / Iris Xe), UEFI. Idle ~70-90 MB.

## What you get
- **WM:** i3 (gaps 4px, no compositor)
- **Bar:** polybar (workspaces, cpu, mem, vol, brightness, battery, clock)
- **Terminal:** alacritty + JetBrainsMono Nerd Font
- **Launcher:** rofi, **Notify:** dunst, **Lock:** i3lock
- **Tools:** nnn, mpv, maim, feh, brightnessctl, playerctl, pamixer

## 1. Fresh Arch install (archinstall choices)
Boot Arch ISO → `archinstall`:
- **Archinstall language:** English
- **Mirrors:** your country
- **Disk:** Partition your spare drive, ext4, encrypt if you want
- **Bootloader:** systemd-boot
- **Profile:** Desktop → **None** (minimal X.org only) — do NOT pick GNOME/KDE
- **Audio:** PipeWire
- **Network:** NetworkManager
- **User:** create user + sudo
- Install, reboot, login as your user.

Intel Iris Xe needs no extra driver (kernel `i915` built-in). No NVIDIA on this machine — nothing to do.

## 2. Get this repo + install
```bash
sudo pacman -Syu git
git clone https://github.com/abr60/arch-i3-minimal.git ~/arch-i3-minimal
cd ~/arch-i3-minimal
./install.sh
./setup.sh
startx
```

## 3. Keybinds
| Keys | Action |
|------|--------|
| Super+Enter | terminal |
| Super+R | launcher |
| Super+L | lock |
| Super+1..9 | workspaces |
| Super+Shift+Q | close |
| Super+Shift+E | exit i3 |
| Super+arrows | navigate |
| Print / Shift+Print | screenshot full / select |
| Fn volume/brightness/media | works via pamixer/brightnessctl/playerctl |

## Verify RAM
After `startx`, open terminal: `free -h` — expect ~120-200 MB used incl. base system.
