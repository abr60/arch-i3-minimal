#!/bin/bash
# capture.sh — screenshots / screen recording / OCR / color (Omarchy trigger.capture port)
# Usage: capture.sh [ocr|color|record|stop]
PIDFILE=/tmp/i3-record.pid
mkdir -p ~/Videos ~/Pictures

case "$1" in
ocr)
  TXT=$(maim -s 2>/dev/null | tesseract stdin stdout -l eng 2>/dev/null)
  if [[ -n $TXT ]]; then
    printf '%s' "$TXT" | xclip -selection clipboard
    notify-send 'OCR' 'Text copied to clipboard' 2>/dev/null || printf '%s\n' "$TXT"
  fi
  ;;
color)
  HEX=$(xcolor 2>/dev/null | head -1)
  if [[ -n $HEX ]]; then
    printf '%s' "$HEX" | xclip -selection clipboard
    notify-send 'Color' "$HEX copied" 2>/dev/null
  fi
  ;;
record)
  if [[ -f $PIDFILE ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    notify-send 'Recording' 'Already recording - use Stop' 2>/dev/null
    exit 1
  fi
  command -v slop >/dev/null || { notify-send 'Recording' 'slop not installed' 2>/dev/null; exit 1; }
  GEO=$(slop -f '%x,%y %w %h' 2>/dev/null) || exit 1
  XY="${GEO% *}"
  WH="${GEO#* }"
  OUT="$HOME/Videos/record-$(date +%Y%m%d-%H%M%S).mp4"
  ffmpeg -y -f x11grab -video_size "$WH" -i ":0.0+$XY" -f pulse -i default "$OUT" &>/dev/null &
  echo $! > "$PIDFILE"
  notify-send 'Recording' "$OUT" 2>/dev/null
  ;;
stop)
  if [[ -f $PIDFILE ]]; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
    notify-send 'Recording' 'Stopped' 2>/dev/null
  fi
  ;;
esac
