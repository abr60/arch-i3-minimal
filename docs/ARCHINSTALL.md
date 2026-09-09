# ARCHINSTALL — exact choices for fresh install on spare drive

Machine: ThinkPad T14 Gen 2i, UEFI. Existing Omarchy install lives on nvme0n1 — DO NOT TOUCH IT.

Boot Arch ISO ( Ventoy or dd ), run `archinstall`.

| # | Prompt | Choice |
|---|--------|--------|
| 1 | Archinstall language | English |
| 2 | Mirrors | your country (or all, default is fine) |
| 3 | Locales | keep default unless you need otherwise |
| 4 | Disk configuration | select ONLY the spare drive |
| 5 | Partitioning | Default layout (auto: 1G ESP + root) |
| 6 | Filesystem | ext4 |
| 7 | Disk encryption | your call (LUKS optional; skip = simpler) |
| 8 | Bootloader | systemd-boot |
| 9 | Unified kernel images | default (off is fine) |
| 10 | Hostname | e.g. `arch` |
| 11 | Root password | set one |
| 12 | User account | add user, sudo = Yes, confirm and exit |
| 13 | Profile | Desktop -> None (CRITICAL: no GNOME/KDE) |
| 14 | Graphics driver | Intel (auto-detected TigerLake, confirm) |
| 15 | Audio | PipeWire |
| 16 | Kernels | linux (default) |
| 17 | Additional packages | none (install.sh handles it) |
| 18 | Network | NetworkManager |
| 19 | Timezone | yours |
| 20 | NTP | Yes |

Install -> reboot -> remove ISO -> boot spare drive via F12 boot menu if needed.

Post-install:
```bash
sudo pacman -Syu git
git clone https://github.com/abr60/arch-i3-minimal ~/arch-i3-minimal
cd ~/arch-i3-minimal
./install.sh
./setup.sh
startx
```

No extra Intel driver needed — kernel i915 covers Iris Xe.
