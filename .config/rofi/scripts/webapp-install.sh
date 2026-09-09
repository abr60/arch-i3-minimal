#!/bin/bash
# webapp-install.sh — create SSB desktop launcher (Omarchy webapp port for i3/X11)
# Usage: webapp-install.sh [name url [icon]]  — interactive if no args
set -e
ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
DESKTOP_DIR="$HOME/.local/share/applications"
ROFI_THEME="$HOME/.config/rofi/config.rasi"
safe_name() { printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^[:alnum:]]\+/-/g; s/^-//; s/-$//'; }
ask() { printf '' | rofi -dmenu -p "$1" -theme "$ROFI_THEME" 2>/dev/null | xargs; }
need_plain_name() { [[ $1 == */* ]] && echo "Name cannot contain '/': $1" >&2 && exit 1; }

normalize_url() {
  local u="$1"
  [[ $u != *://* ]] && u="https://$u"
  printf '%s' "$u"
}
require_http() {
  [[ $1 =~ [[:space:]] ]] && echo "URL must not contain whitespace" >&2 && exit 1
  [[ ${1,,} == http://* || ${1,,} == https://* ]] || { echo "URL must be http(s): $1" >&2; exit 1; }
}
fetch_icon() {
  local url="$1" dest="$2"
  local origin page icon_url
  origin=$(sed -E 's|^(https?://[^/]+).*|\1|' <<<"$url")
  page=$(curl -fsSL --max-time 5 "$url" 2>/dev/null | head -c 100000 | tr '\n' ' ') || page=""
  icon_url=$(grep -oiE '<link[^>]*rel=["'\''][^"'\''"]*apple-touch-icon[^"'\''"]*["'\''][^>]*>' <<<"$page" | grep -oiE 'href=["'\''][^"'\''"]+' | head -1 | sed -E 's/^href=["'\'']//')
  case $icon_url in http://*|https://*) ;; //*) icon_url="https:$icon_url" ;; /*) icon_url="$origin$icon_url" ;; ?*) icon_url="$origin/$icon_url" ;; esac
  mkdir -p "$(dirname "$dest")"
  { [[ -n $icon_url ]] && curl -fsSL --max-time 10 -o "$dest" "$icon_url" 2>/dev/null && [[ -s $dest ]]; } \
    || curl -fsSL --max-time 10 -o "$dest" "$origin/apple-touch-icon.png" 2>/dev/null && [[ -s $dest ]] \
    || curl -fsSL --max-time 10 -o "$dest" "https://www.google.com/s2/favicons?domain=${url}&sz=256" 2>/dev/null && [[ -s $dest ]]
}

if (( $# >= 2 )); then
  APP_NAME="$1"; APP_URL=$(normalize_url "$2"); ICON_REF="${3:-}"
  require_http "$APP_URL"; need_plain_name "$APP_NAME"
  INTERACTIVE=false
else
  APP_NAME=$(ask "Webapp name")
  [[ -z $APP_NAME ]] && exit 0; need_plain_name "$APP_NAME"
  _url=$(ask "URL (https://...)")
  [[ -z $_url ]] && exit 0; APP_URL=$(normalize_url "$_url"); require_http "$APP_URL"
  ICON_REF=""
  INTERACTIVE=true
fi

mkdir -p "$ICON_DIR" "$DESKTOP_DIR"
ICON_VALUE=$(safe_name "$APP_NAME")
# try auto-fetch if no icon ref
if [[ -z $ICON_REF ]]; then
  if fetch_icon "$APP_URL" "$ICON_DIR/$ICON_VALUE.png"; then ICON_REF="$ICON_VALUE"; gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" &>/dev/null || true
  else
    # prompt for icon
    if [[ $INTERACTIVE == true ]]; then
      ICON_REF=$(ask "Icon URL or name (enter to skip)")
      if [[ $ICON_REF == https://* ]]; then
        curl -fsSL --max-time 10 -o "$ICON_DIR/$ICON_VALUE.png" "$ICON_REF" 2>/dev/null || true
        ICON_REF="$ICON_VALUE"; gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" &>/dev/null || true
      elif [[ -n $ICON_REF && -f $ICON_REF ]]; then
        cp "$ICON_REF" "$ICON_DIR/$ICON_VALUE.${ICON_REF##*.}"; ICON_REF="$ICON_VALUE"
      elif [[ -n $ICON_REF ]]; then
        ICON_VALUE="$ICON_REF"
      else ICON_REF="$ICON_VALUE"; fi
    else ICON_REF="$ICON_VALUE"; fi
  fi
elif [[ $ICON_REF == https://* || $ICON_REF == http://* ]]; then
  curl -fsSL --max-time 10 -o "$ICON_DIR/$ICON_VALUE.png" "$ICON_REF" 2>/dev/null || true
  gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" &>/dev/null || true
  ICON_REF="$ICON_VALUE"
elif [[ -f $ICON_REF ]]; then
  cp "$ICON_REF" "$ICON_DIR/$ICON_VALUE.${ICON_REF##*.}"; ICON_REF="$ICON_VALUE"
else
  ICON_VALUE=$(basename "$ICON_REF"); ICON_VALUE=${ICON_VALUE%.*}; ICON_VALUE=$(safe_name "$ICON_VALUE"); ICON_REF="$ICON_VALUE"
fi

# Exec uses our launcher script
EXEC="sh -c 'exec ~/.config/rofi/scripts/webapp-launch.sh \"\$1\" \"\$1\"' _ $APP_URL"
# desktop entry escaping
esc() { local v="$1"; v=${v//\\/\\\\}; v=${v//$'\t'/\\t}; v=${v//$'\r'/\\r}; v=${v//$'\n'/\\n}; [[ $v == " "* ]] && v="\\s${v# }"; printf '%s' "$v"; }
name_f=$(esc "$APP_NAME"); exec_f=$(esc "sh -c 'exec ~/.config/rofi/scripts/webapp-launch.sh \"\$1\"' _ $APP_URL")
icon_f=$(esc "$ICON_REF")
cat > "$DESKTOP_DIR/$APP_NAME.desktop" <<EOF
[Desktop Entry]
Version=1.0
Name=$name_f
Comment=$name_f
Exec=$exec_f
Terminal=false
Type=Application
Icon=$icon_f
StartupNotify=true
EOF
chmod +x "$DESKTOP_DIR/$APP_NAME.desktop"
update-desktop-database "$DESKTOP_DIR" &>/dev/null || true
notify-send "Webapp installed" "$APP_NAME" 2>/dev/null || true
[[ $INTERACTIVE == true ]] && echo "Installed $APP_NAME — find it with Super+Space"
