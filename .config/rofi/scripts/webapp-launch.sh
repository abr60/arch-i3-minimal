#!/bin/bash
# webapp-launch.sh — Omarchy launch-webapp port for X11/i3
# Opens URL as SSB (--app) in preferred browser.
set -e
url="${1:?url required}"
# prefer chromium family if installed
for b in chromium google-chrome-stable brave brave-browser microsoft-edge chromium-browser; do
  if command -v "$b" >/dev/null 2>&1; then exec "$b" --app="$url" "${@:2}"; fi
done
# check default browser .desktop Exec
browser_desktop=$(xdg-settings get default-web-browser 2>/dev/null || echo "")
case "$browser_desktop" in google-chrome*|brave*|microsoft-edge*|chromium*|chrome*)
  exe=$(sed -n 's/^Exec=\([^ ]*\).*/\1/p' {~/.local,~/.nix-profile,/usr}/share/applications/"$browser_desktop" 2>/dev/null | head -1)
  [[ -n $exe && -x $exe ]] && exec "$exe" --app="$url" "${@:2}"
  ;;
esac
# firefox SSB (modern)
if command -v firefox >/dev/null 2>&1; then exec firefox --ssb "$url" "${@:2}" 2>/dev/null || exec firefox --new-window "$url" "${@:2}"; fi
exec xdg-open "$url"
