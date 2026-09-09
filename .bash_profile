# arch-i3-minimal .bash_profile — auto-startx on TTY1 (no DM)
# Starts X on the primary virtual terminal only once.
[[ -z "$DISPLAY" ]] && [[ "$XDG_VTNR" -eq 1 ]] && exec startx