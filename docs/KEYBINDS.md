# KEYBINDS — Omarchy-ported reference (Super = Mod4 = Windows key)

## Menu + Apps
| Keys | Action |
|------|--------|
| Super+Space | launcher (rofi drun) |
| Super+Alt+Space | central menu (menu.sh: trigger/style/setup/install/learn/update/about/system) |
| Super+Escape | system menu (lock/suspend/logout/reboot/shutdown) |
| Super+Enter | terminal (alacritty) |
| Super+Shift+Enter | browser (firefox) |
| Super+Shift+F | file manager (thunar) |
| Super+Ctrl+Q | calculator (rofi calc) |
| Super+Ctrl+E | emoji picker (rofi emoji) |
| Super+Ctrl+V | clipboard history (clipmenu) |
| Super+A | launch default coding agent (arch-agent, like Omarchy) |
| Super+Shift+Ctrl+A | agent picker (arch-agent --pick) |
| Super+grave | window switcher (rofi -show window, Overview parity) |
| Super+K | this keybind list |
| Super+Ctrl+R | set reminder |

## Toggles (menu.sh ▸ Toggle shows ✓ state — `arch-toggle`)
| Keys | Action |
|------|--------|
| XF86TouchpadToggle | touchpad on/off (`arch-toggle touchpad`) |
| Super+Shift+Space | polybar show/hide (`arch-toggle bar`) |
| Super+Ctrl+N | night light toggle (`arch-toggle nightlight`) |

## Windows
| Keys | Action |
|------|--------|
| Super+W | close window |
| Super+J | toggle split direction |
| Super+T | floating toggle |
| Super+F | fullscreen |
| Super+arrows | focus |
| Super+Shift+arrows | swap windows |
| Super+Tab / Super+Shift+Tab | next / prev workspace |
| Super+1..9 | switch workspace |
| Super+Shift+1..9 | move to workspace |

## Clipboard (xclip)
| Keys | Action |
|------|--------|
| Super+C | copy |
| Super+V | paste |
| Super+X | cut |

## Capture (`arch-capture`)
| Keys | Action |
|------|--------|
| Print | fullscreen screenshot (`arch-capture screenshot full`) |
| Super+Print / Shift+Print | region screenshot |
| Super+Ctrl+Print | OCR region → clipboard |
| Super+Shift+Print | color picker → clipboard |
| Alt+Print | screen record toggle (ffmpeg, ~/Videos) |

## System (`arch-system` / `arch-update`)
| Keys | Action |
|------|--------|
| Super+L | lock (`arch-system lock`; auto 5 min idle + suspend via xss-lock) |
| Super+Shift+C | reload i3 |
| Super+Shift+E | exit i3 (`arch-system logout`) |
| Polybar `UPD N` | click → `arch-update system` (pacman -Syu + yay + dotfiles re-sync) |

## Media (ThinkPad Fn keys)
Volume via pamixer, brightness via brightnessctl (+5% steps, Shift = min/max),
media via playerctl. See `.config/i3/config` for the full list.
