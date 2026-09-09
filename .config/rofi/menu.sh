#!/bin/bash
# arch-i3-minimal menu — Omarchy-style central menu (rofi, recursive routes)
# Usage: menu.sh [root|system|trigger|toggle|style|setup|setup-security|install|learn]
ROUTE="${1:-root}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROFI="rofi -dmenu -p"
THEME="$HOME/.config/rofi/config.rasi"

pick() { # pick <prompt> <lines...> -> prints selection
  local prompt="$1"; shift
  printf '%s\n' "$@" | $ROFI "$prompt" -theme "$THEME"
}

case "$ROUTE" in
root)
  case "$(pick 'Menu' 'Apps' 'Trigger' 'Toggle' 'System' 'Style' 'Setup' 'Install' 'Learn' 'Update' 'About')" in
    Apps)    rofi -show drun -theme "$THEME" ;;
    Trigger) "$0" trigger ;;
    Toggle)  "$0" toggle ;;
    System)  "$0" system ;;
    Style)   "$0" style ;;
    Setup)   "$0" setup ;;
    Install) "$0" install ;;
    Learn)   "$0" learn ;;
    Update)  alacritty -e ~/arch-i3-minimal/update.sh ;;
    About)   alacritty -e fastfetch ;;
  esac ;;
system)
  case "$(pick 'Power' 'Lock' 'Suspend' 'Logout' 'Reboot' 'Shutdown')" in
    Lock)     i3lock -c 1a1a1a ;;
    Suspend)  systemctl suspend ;;
    Logout)   i3-msg exit ;;
    Reboot)   systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
  esac ;;
trigger)
  case "$(pick 'Trigger' 'Screenshot full' 'Screenshot region' 'Record screen' 'Stop recording' 'OCR text' 'Color picker' 'Emoji' 'Calculator' 'Reminder' 'Clipboard history' 'Nightlight toggle' 'Bluetooth')" in
    'Screenshot full')   maim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png ;;
    'Screenshot region') maim -s ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png ;;
    'Record screen')     "$SCRIPT_DIR/scripts/capture.sh" record ;;
    'Stop recording')    "$SCRIPT_DIR/scripts/capture.sh" stop ;;
    'OCR text')          "$SCRIPT_DIR/scripts/capture.sh" ocr ;;
    'Color picker')      "$SCRIPT_DIR/scripts/capture.sh" color ;;
    Emoji)               rofi -show emoji -modi emoji -theme "$THEME" ;;
    Calculator)          rofi -show calc -modi calc -theme "$THEME" ;;
    Reminder)            alacritty -e "$SCRIPT_DIR/scripts/reminder.sh" set ;;
    'Clipboard history') clipmenu ;;
    'Nightlight toggle') pkill redshift || redshift -l 0:0 -t 6500:3500 & ;;
    Bluetooth)           "$SCRIPT_DIR/scripts/bluetooth.sh" ;;
  esac ;;
toggle)
  st=$("$SCRIPT_DIR/scripts/toggle.sh" state)
  mark() { [[ $st == *"$1=on"* ]] && echo '✓' || echo ' '; }
  TP="Touchpad [$(mark touchpad)]"; ID="Stay Awake [$(mark idle)]"
  BR="Menu Bar [$(mark bar)]";   NT="Notifications [$(mark notify)]"
  case "$(pick 'Toggle' "$TP" "$ID" "$BR" "$NT")" in
    "$TP") "$SCRIPT_DIR/scripts/toggle.sh" touchpad ;;
    "$ID") "$SCRIPT_DIR/scripts/toggle.sh" idle ;;
    "$BR") "$SCRIPT_DIR/scripts/toggle.sh" bar ;;
    "$NT") "$SCRIPT_DIR/scripts/toggle.sh" notify ;;
  esac ;;
style)
  case "$(pick 'Style' 'Background' 'Toggle gaps' 'Reload i3')" in
    Background)  BG=$(ls ~/Pictures/wallpapers/* 2>/dev/null | $ROFI 'Wallpaper' -theme "$THEME"); [[ -n $BG ]] && feh --bg-fill "$BG" && cp "$BG" ~/.wallpaper ;;
    'Toggle gaps') i3-msg gaps inner current toggle 8 \; gaps outer current toggle 8 >/dev/null ;;
    'Reload i3')   i3-msg reload ;;
  esac ;;
setup)
  case "$(pick 'Setup' 'Security' 'Edit i3 config' 'Edit menu')" in
    Security)        "$0" setup-security ;;
    'Edit i3 config') alacritty -e nano ~/.config/i3/config ;;
    'Edit menu')      alacritty -e nano ~/.config/rofi/menu.sh ;;
  esac ;;
setup-security)
  case "$(pick 'Security' 'Howdy face unlock' 'Passwordless sudo')" in
    'Howdy face unlock') alacritty -e "$SCRIPT_DIR/scripts/setup-howdy.sh" ;;
    'Passwordless sudo') alacritty -e bash -c "echo '%wheel ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/wheel-nopasswd && echo OK && sleep 2" ;;
  esac ;;
install)
  case "$(pick 'Install' 'Package' 'Howdy (AUR)' 'Nerd fonts')" in
    Package)      PKG=$(printf '' | $ROFI 'pacman -S' -theme "$THEME"); [[ -n $PKG ]] && alacritty -e bash -c "sudo pacman -S --needed $PKG; sleep 3" ;;
    'Howdy (AUR)') alacritty -e "$SCRIPT_DIR/scripts/setup-howdy.sh" install ;;
    'Nerd fonts')  alacritty -e bash -c "sudo pacman -S --needed ttf-jetbrains-mono-nerd ttf-cascadia-mono-nerd ttf-firacode-nerd; sleep 3" ;;
  esac ;;
learn)
  case "$(pick 'Learn' 'Keybindings' 'Arch Wiki')" in
    Keybindings) alacritty -e less ~/arch-i3-minimal/docs/KEYBINDS.md ;;
    'Arch Wiki') firefox 'https://wiki.archlinux.org/title/Main_page' ;;
  esac ;;
esac
