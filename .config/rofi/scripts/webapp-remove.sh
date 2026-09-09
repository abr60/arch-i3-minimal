#!/bin/bash
# webapp-remove.sh — remove webapp .desktop + icon (Omarchy port)
set -e
ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
DESKTOP_DIR="$HOME/.local/share/applications"
ROFI_THEME="$HOME/.config/rofi/config.rasi"
mapfile -t APPS < <(grep -l '^Exec=.*webapp-launch' "$DESKTOP_DIR"/*.desktop 2>/dev/null | xargs -r -n1 basename | sed 's/\.desktop$//')
if (( ${#APPS[@]} == 0 )); then notify-send "No webapps to remove" 2>/dev/null; echo "No webapps found."; exit 0; fi
if (( $# == 0 )); then
  APP_NAME=$(printf '%s\n' "${APPS[@]}" | sort | rofi -dmenu -p "Remove webapp" -theme "$ROFI_THEME")
else APP_NAME="$*"; fi
[[ -z $APP_NAME ]] && exit 0
icon=$(printf '%s' "$APP_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^[:alnum:]]\+/-/g; s/^-//; s/-$//')
rm -f "$DESKTOP_DIR/$APP_NAME.desktop"
rm -f "$ICON_DIR/$icon.png" "$ICON_DIR/$APP_NAME.png"
update-desktop-database "$DESKTOP_DIR" &>/dev/null || true
notify-send "Webapp removed" "$APP_NAME" 2>/dev/null || true
echo "Removed $APP_NAME"
