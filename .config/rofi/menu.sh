#!/bin/bash
# arch-i3-minimal menu — Omarchy-style central menu (rofi, recursive routes)
# Root: Apps / Learn / Trigger / Style / Setup / Install / Remove / Update / About / System / Toggle
# Mirrors /usr/share/omarchy/default/omarchy/omarchy-menu.jsonc — adapted for i3/X11
ROUTE="${1:-root}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROFI="rofi -dmenu -p"
THEME="$HOME/.config/rofi/config.rasi"
REPO="$HOME/arch-i3-minimal"; [[ -d $REPO ]] || REPO="$(cd "$SCRIPT_DIR/../.." && pwd)"

pick() { local p="$1"; shift; printf '%s\n' "$@" | $ROFI "$p" -theme "$THEME"; }
ask() { rofi -dmenu -p "$1" -theme "$THEME" | xargs; }
notify() { notify-send "$1" "$2" 2>/dev/null || true; }
has() { command -v "$1" >/dev/null 2>&1; }

case "$ROUTE" in
root)
  case "$(pick 'Menu' 'Apps' 'Learn' 'Trigger' 'Toggle' 'Style' 'Setup' 'Install' 'Remove' 'Update' 'About' 'System')" in
    Apps)    rofi -show drun -theme "$THEME" ;;
    Learn)   "$0" learn ;;
    Trigger) "$0" trigger ;;
    Toggle)  "$0" toggle ;;
    Style)   "$0" style ;;
    Setup)   "$0" setup ;;
    Install) "$0" install ;;
    Remove)  "$0" remove ;;
    Learn*)  "$0" learn ;;
    Update)  alacritty -e bash -c "$REPO/update.sh; echo Done; read -n1" ;;
    About)   "$0" about ;;
    System)  "$0" system ;;
  esac ;;

learn)
  case "$(pick 'Learn' 'Keybindings' 'i3 Manual' 'Arch Wiki' 'Bash Cheatsheet' 'Polybar' 'Rofi')" in
    Keybindings)      alacritty -e less "$REPO/docs/KEYBINDS.md" ;;
    'i3 Manual')     firefox 'https://i3wm.org/docs/userguide.html' & ;;
    'Arch Wiki')     firefox 'https://wiki.archlinux.org/title/Main_page' & ;;
    'Bash Cheatsheet') firefox 'https://devhints.io/bash' & ;;
    Polybar)         firefox 'https://github.com/polybar/polybar/wiki' & ;;
    Rofi)            firefox 'https://github.com/davatorium/rofi' & ;;
  esac ;;

trigger)
  case "$(pick 'Trigger' 'Emoji' 'Reminder' 'Capture' 'Share' 'Toggle…' 'Hardware' 'Speed Test' 'Clipboard history' 'Color picker' 'OCR text')" in
    Emoji)             rofi -show emoji -modi emoji -theme "$THEME" ;;
    Reminder)          "$0" trigger-reminder ;;
    Capture)           "$0" trigger-capture ;;
    Share)             "$0" trigger-share ;;
    'Toggle…'|Toggle) "$0" toggle ;;
    Hardware)          "$0" trigger-hardware ;;
    'Speed Test')      alacritty -e bash -c 'speedtest-cli 2>/dev/null || curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3; read -n1' ;;
    'Clipboard history') clipmenu ;;
    'Color picker')    "$SCRIPT_DIR/scripts/capture.sh" color ;;
    'OCR text')        "$SCRIPT_DIR/scripts/capture.sh" ocr ;;
  esac ;;

trigger-reminder)
  case "$(pick 'Reminder' 'Set one' 'Show all' 'Clear all')" in
    'Set one')  alacritty -e "$SCRIPT_DIR/scripts/reminder.sh" set ;;
    'Show all') "$SCRIPT_DIR/scripts/reminder.sh" show ;;
    'Clear all') "$SCRIPT_DIR/scripts/reminder.sh" clear ;;
  esac ;;

trigger-capture)
  case "$(pick 'Capture' 'Screenshot (full)' 'Screenshot (region)' 'Screenrecord (start)' 'Stop Screenrecording' 'OCR Text' 'QR Code' 'Color')" in
    'Screenshot (full)') maim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png && notify "Screenshot" "Saved to ~/Pictures" ;;
    'Screenshot (region)') maim -s ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png && notify "Screenshot" "Saved" ;;
    'Screenrecord (start)') "$SCRIPT_DIR/scripts/capture.sh" record ;;
    'Stop Screenrecording') "$SCRIPT_DIR/scripts/capture.sh" stop ;;
    'OCR Text') "$SCRIPT_DIR/scripts/capture.sh" ocr ;;
    'QR Code')  alacritty -e bash -c 'echo "QR: maim -s | zbarimg --raw - 2>/dev/null | xclip -sel clip; echo done; read -n1"' ;;
    Color)      "$SCRIPT_DIR/scripts/capture.sh" color ;;
  esac ;;

trigger-share)
  case "$(pick 'Share' 'Clipboard (copy)' 'File' 'Folder' 'Receive (localsend)')" in
    'Clipboard (copy)') rofi -show emoji -modi emoji -theme "$THEME" ;;
    File)   FILE=$(pick 'File' $(ls ~/ 2>/dev/null)); [[ -n $FILE ]] && echo -n "$FILE" | xclip -sel clip && notify "Share" "Path copied" ;;
    Folder) notify "Share" "Use thunar + right-click share (localsend)" ;;
    'Receive (localsend)') if has localsend 2>/dev/null; then localsend & else notify "Share" "localsend not installed"; fi ;;
  esac ;;

trigger-hardware)
  case "$(pick 'Hardware' 'Touchpad toggle' 'Touchscreen toggle' 'Laptop display toggle' 'Bluetooth')" in
    'Touchpad toggle') "$SCRIPT_DIR/scripts/toggle.sh" touchpad ;;
    'Touchscreen toggle') notify "Hardware" "Touchscreen toggle — xinput disable <id>" ;;
    'Laptop display toggle') alacritty -e bash -c 'xrandr --listmonitors; read -n1' ;;
    Bluetooth) "$SCRIPT_DIR/scripts/bluetooth.sh" ;;
  esac ;;

toggle)
  st=$("$SCRIPT_DIR/scripts/toggle.sh" state 2>/dev/null)
  mark() { [[ $st == *"$1=on"* ]] && echo '✓' || echo ' '; }
  TP="Touchpad [$(mark touchpad)]"; ID="Stay Awake [$(mark idle)]"
  BR="Menu Bar [$(mark bar)]";   NT="Notifications [$(mark notify)]"
  NL="Nightlight [ ]"; GAP="Window Gaps [✓]"
  # detect redshift/nightlight
  pgrep -x redshift >/dev/null && NL="Nightlight [✓]"
  CH=$(pick 'Toggle' "$TP" "$ID" "$BR" "$NT" "$NL" "$GAP" 'Battery %' 'Screensaver')
  case "$CH" in
    "$TP") "$SCRIPT_DIR/scripts/toggle.sh" touchpad ;;
    "$ID") "$SCRIPT_DIR/scripts/toggle.sh" idle ;;
    "$BR") "$SCRIPT_DIR/scripts/toggle.sh" bar ;;
    "$NT") "$SCRIPT_DIR/scripts/toggle.sh" notify ;;
    "$NL") pkill redshift 2>/dev/null || redshift -l 0:0 -t 6500:3500 & ;;
    "$GAP") i3-msg gaps inner current toggle 8 \; gaps outer current toggle 8 >/dev/null ;;
    'Battery %') notify "Battery" "$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)% — toggles polybar battery module" ;;
    Screensaver) pkill xss-lock 2>/dev/null || xss-lock -- i3lock -c 1a1a1a & ;;
  esac ;;

style)
  case "$(pick 'Style' 'Background' 'Bar position' 'Transparency' 'Toggle gaps' 'Font' 'Screensaver text' 'Reload i3' 'Reload polybar')" in
    Background)  BG=$(ls ~/Pictures/wallpapers/* 2>/dev/null | $ROFI 'Wallpaper' -theme "$THEME"); [[ -n $BG ]] && feh --bg-fill "$BG" && cp "$BG" ~/.wallpaper && notify "Style" "Wallpaper set" ;;
    'Bar position')
      case "$(pick 'Bar position' 'Top' 'Bottom')" in
        Top) sed -i 's/^bottom = true/bottom = false/' ~/.config/polybar/config.ini; ~/.config/polybar/launch.sh & ;;
        Bottom) sed -i 's/^bottom = false/bottom = true/' ~/.config/polybar/config.ini; ~/.config/polybar/launch.sh & ;;
      esac ;;
    Transparency) notify "Style" "Edit ~/.config/polybar/config.ini background alpha" ;;
    'Toggle gaps') i3-msg gaps inner current toggle 8 \; gaps outer current toggle 8 >/dev/null ;;
    Font) alacritty -e nano ~/.Xresources ;;
    'Screensaver text') alacritty -e nano ~/.config/i3/config ;;
    'Reload i3') i3-msg reload ;;
    'Reload polybar') ~/.config/polybar/launch.sh & ;;
  esac ;;

setup)
  case "$(pick 'Setup' 'Monitors' 'Keybindings' 'Network / DNS' 'Defaults' 'Security' 'Edit i3 config' 'Edit polybar' 'Edit menu' 'Edit rofi theme')" in
    Monitors)        alacritty -e nano ~/.config/i3/config ;;
    Keybindings)     alacritty -e nano ~/.config/i3/config ;;
    'Network / DNS') "$0" setup-network ;;
    Defaults)        "$0" setup-default ;;
    Security)        "$0" setup-security ;;
    'Edit i3 config') alacritty -e nano ~/.config/i3/config ;;
    'Edit polybar')   alacritty -e nano ~/.config/polybar/config.ini ;;
    'Edit menu')      alacritty -e nano ~/.config/rofi/menu.sh ;;
    'Edit rofi theme') alacritty -e nano ~/.config/rofi/matugen.rasi ;;
  esac ;;

setup-network)
  case "$(pick 'Network' 'nmtui (WiFi)' 'DNS: DHCP' 'DNS: Cloudflare (1.1.1.1)' 'DNS: Google (8.8.8.8)' 'QR WiFi')" in
    'nmtui (WiFi)') alacritty -e nmtui ;;
    'DNS: DHCP') sudo sh -c 'echo nameserver 127.0.0.1 > /etc/resolv.conf; systemctl restart NetworkManager' 2>/dev/null; notify "DNS" "DHCP" ;;
    'DNS: Cloudflare (1.1.1.1)') echo -e "[main]\ndns=none\n" | sudo tee /etc/NetworkManager/conf.d/dns.conf >/dev/null; echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf >/dev/null; notify "DNS" "Cloudflare" ;;
    'DNS: Google (8.8.8.8)') echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf >/dev/null; notify "DNS" "Google" ;;
    'QR WiFi') notify "QR" "Use nmtui or nm-connection-editor" ;;
  esac ;;

setup-default)
  case "$(pick 'Defaults' 'Browser' 'Editor' 'Terminal' 'File manager')" in
    Browser)  B=$(pick 'Browser' 'firefox' 'chromium' 'google-chrome' 'brave'); [[ -n $B ]] && xdg-settings set default-web-browser "$B.desktop" 2>/dev/null; notify "Default" "Browser: $B" ;;
    Editor)   E=$(pick 'Editor' 'nvim' 'nano' 'code' 'zed'); [[ -n $E ]] && notify "Default" "Editor: $E (set \$EDITOR in ~/.bashrc)" ;;
    Terminal) T=$(pick 'Terminal' 'alacritty' 'foot' 'kitty' 'ghostty'); [[ -n $T ]] && notify "Default" "Terminal: $T (set in ~/.config/i3/config)" ;;
    'File manager') notify "Default" "thunar is default (xdg-mime)" ;;
  esac ;;

setup-security)
  case "$(pick 'Security' 'Howdy face unlock' 'Fingerprint' 'SSHD' 'Passwordless sudo' 'Fido2')" in
    'Howdy face unlock') alacritty -e "$SCRIPT_DIR/scripts/setup-howdy.sh" ;;
    Fingerprint) alacritty -e bash -c 'fprintd-enroll 2>/dev/null || echo "fprintd not installed"; read -n1' ;;
    SSHD) alacritty -e bash -c 'sudo systemctl enable --now sshd; echo done; read -n1' ;;
    'Passwordless sudo') alacritty -e bash -c "echo '%wheel ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/wheel-nopasswd && echo OK && sleep 2" ;;
    Fido2) notify "Security" "Fido2 via pam-u2f — see docs" ;;
  esac ;;

install)
  case "$(pick 'Install' 'Package' 'AUR package' 'Web App' 'TUI (terminal app)' 'Nerd fonts' 'Service' 'Browser' 'Editor' 'Terminal' 'AI' 'Gaming' 'Development')" in
    Package)      alacritty --class pkg -e "$SCRIPT_DIR/scripts/pkg-install.sh" & ;;
    'AUR package') alacritty --class pkg -e "$SCRIPT_DIR/scripts/pkg-aur-install.sh" & ;;
    'Web App')    "$SCRIPT_DIR/scripts/webapp-install.sh" ;;
    'TUI (terminal app)') alacritty -e bash -c 'read -p "TUI name> " n; read -p "Command> " c; echo "Use webapp-install logic for TUI .desktop with alacritty -e \$c"; read -n1' ;;
    'Nerd fonts')  alacritty -e bash -c "sudo pacman -S --needed ttf-jetbrains-mono-nerd ttf-cascadia-mono-nerd ttf-firacode-nerd ttf-iosevka-nerd; sleep 2" ;;
    Service)      "$0" install-service ;;
    Browser)      "$0" install-browser ;;
    Editor)       "$0" install-editor ;;
    Terminal)     "$0" install-terminal ;;
    AI)           "$0" install-ai ;;
    Gaming)       "$0" install-gaming ;;
    Development)  "$0" install-development ;;
  esac ;;

install-service)
  case "$(pick 'Service' '1Password' 'Dropbox' 'Spotify' 'Signal' 'Tailscale' 'NordVPN' 'Bitwarden')" in
    1Password) alacritty -e bash -c 'yay -S --needed 1password 2>/dev/null || sudo pacman -S --needed 1password; read -n1' ;;
    Dropbox)   alacritty -e bash -c 'yay -S --needed dropbox 2>/dev/null || echo "AUR only"; read -n1' ;;
    Spotify)   alacritty -e bash -c 'yay -S --needed spotify 2>/dev/null || sudo pacman -S --needed spotify-launcher; read -n1' ;;
    Signal)    alacritty -e bash -c 'sudo pacman -S --needed signal-desktop 2>/dev/null || yay -S --needed signal-desktop; read -n1' ;;
    Tailscale) alacritty -e bash -c 'sudo pacman -S --needed tailscale; sudo systemctl enable --now tailscaled; read -n1' ;;
    NordVPN)   alacritty -e bash -c 'yay -S --needed nordvpn-bin; sudo systemctl enable --now nordvpnd; read -n1' ;;
    Bitwarden) alacritty -e bash -c 'sudo pacman -S --needed bitwarden 2>/dev/null || yay -S --needed bitwarden; read -n1' ;;
  esac ;;

install-browser)
  case "$(pick 'Browser' 'Chrome' 'Brave' 'Edge' 'Firefox' 'Zen' 'Chromium')" in
    Chrome)    alacritty -e bash -c 'yay -S --needed google-chrome 2>/dev/null || echo failed; read -n1' ;;
    Brave)     alacritty -e bash -c 'yay -S --needed brave-bin; read -n1' ;;
    Edge)      alacritty -e bash -c 'yay -S --needed microsoft-edge-stable-bin; read -n1' ;;
    Firefox)   alacritty -e bash -c 'sudo pacman -S --needed firefox; read -n1' ;;
    Zen)       alacritty -e bash -c 'yay -S --needed zen-browser-bin; read -n1' ;;
    Chromium)  alacritty -e bash -c 'sudo pacman -S --needed chromium; read -n1' ;;
  esac ;;

install-editor)
  case "$(pick 'Editor' 'VSCode' 'Cursor' 'Zed' 'Sublime' 'Helix' 'Neovim')" in
    VSCode)  alacritty -e bash -c 'yay -S --needed visual-studio-code-bin; read -n1' ;;
    Cursor)  alacritty -e bash -c 'yay -S --needed cursor-bin; read -n1' ;;
    Zed)     alacritty -e bash -c 'sudo pacman -S --needed zed 2>/dev/null || yay -S --needed zed; read -n1' ;;
    Sublime) alacritty -e bash -c 'yay -S --needed sublime-text-4; read -n1' ;;
    Helix)   alacritty -e bash -c 'sudo pacman -S --needed helix; read -n1' ;;
    Neovim)  alacritty -e bash -c 'sudo pacman -S --needed neovim; read -n1' ;;
  esac ;;

install-terminal)
  case "$(pick 'Terminal' 'Alacritty' 'Foot' 'Kitty' 'Ghostty')" in
    Alacritty) alacritty -e bash -c 'sudo pacman -S --needed alacritty; read -n1' ;;
    Foot)      alacritty -e bash -c 'sudo pacman -S --needed foot; read -n1' ;;
    Kitty)     alacritty -e bash -c 'sudo pacman -S --needed kitty; read -n1' ;;
    Ghostty)   alacritty -e bash -c 'yay -S --needed ghostty 2>/dev/null || sudo pacman -S --needed ghostty; read -n1' ;;
  esac ;;

install-ai)
  case "$(pick 'AI' 'Ollama' 'LM Studio' 'ChatGPT Desktop' 'Perplexity' 'Hermes' 'Dictation (voxtype)')" in
    Ollama)              alacritty -e bash -c 'yay -S --needed ollama 2>/dev/null || sudo pacman -S --needed ollama; read -n1' ;;
    'LM Studio')        alacritty -e bash -c 'yay -S --needed lmstudio-bin; read -n1' ;;
    'ChatGPT Desktop')  alacritty -e bash -c 'yay -S --needed openai-codex-desktop 2>/dev/null || echo not found; read -n1' ;;
    Perplexity)         alacritty -e bash -c 'yay -S --needed perplexity 2>/dev/null || echo not found; read -n1' ;;
    Hermes)             alacritty -e bash -c 'yay -S --needed hermes-desktop 2>/dev/null || echo not found; read -n1' ;;
    'Dictation (voxtype)') alacritty -e bash -c 'yay -S --needed voxtype-bin; read -n1' ;;
  esac ;;

install-gaming)
  case "$(pick 'Gaming' 'Steam' 'RetroArch' 'Minecraft' 'Lutris' 'Heroic' 'GeForce NOW' 'Xbox Cloud')" in
    Steam)      alacritty -e bash -c 'sudo pacman -S --needed steam; read -n1' ;;
    RetroArch)  alacritty -e bash -c 'sudo pacman -S --needed retroarch; read -n1' ;;
    Minecraft)  alacritty -e bash -c 'yay -S --needed minecraft-launcher 2>/dev/null || sudo pacman -S --needed minecraft-launcher; read -n1' ;;
    Lutris)     alacritty -e bash -c 'sudo pacman -S --needed lutris; read -n1' ;;
    Heroic)     alacritty -e bash -c 'yay -S --needed heroic-games-launcher-bin; read -n1' ;;
    'GeForce NOW') firefox 'https://www.nvidia.com/en-us/geforce-now/' & ;;
    'Xbox Cloud') "$SCRIPT_DIR/scripts/webapp-install.sh" 'Xbox Cloud Gaming' 'https://www.xbox.com/play' ;;
  esac ;;

install-development)
  case "$(pick 'Development' 'Ruby on Rails' 'Docker DB' 'JavaScript (mise)' 'Go' 'PHP')" in
    'Ruby on Rails') alacritty -e bash -c 'mise install ruby 2>/dev/null || sudo pacman -S --needed ruby; read -n1' ;;
    'Docker DB')     alacritty -e bash -c 'sudo pacman -S --needed docker docker-compose; sudo systemctl enable --now docker; read -n1' ;;
    'JavaScript (mise)') alacritty -e bash -c 'mise install node 2>/dev/null || sudo pacman -S --needed nodejs npm; read -n1' ;;
    Go)             alacritty -e bash -c 'sudo pacman -S --needed go; read -n1' ;;
    PHP)            alacritty -e bash -c 'sudo pacman -S --needed php; read -n1' ;;
  esac ;;

remove)
  case "$(pick 'Remove' 'Package' 'Orphaned packages' 'Web App' 'TUI' 'Theme' 'Browser' 'Service' 'Gaming')" in
    Package)            alacritty --class pkg -e "$SCRIPT_DIR/scripts/pkg-remove.sh" & ;;
    'Orphaned packages') alacritty --class pkg -e "$SCRIPT_DIR/scripts/pkg-orphans.sh" & ;;
    'Web App')          "$SCRIPT_DIR/scripts/webapp-remove.sh" ;;
    TUI)  DESK=$(ls ~/.local/share/applications/*.desktop 2>/dev/null | xargs grep -l 'alacritty -e' | xargs -r basename -a | sed 's/.desktop//'); C=$(printf '%s\n' $DESK | $ROFI 'Remove TUI' -theme "$THEME"); [[ -n $C ]] && rm -v ~/.local/share/applications/"$C.desktop" ;;
    Theme) notify "Remove" "Themes are in ~/.config — delete manually" ;;
    Browser) "$0" remove-browser ;;
    Service) "$0" remove-service ;;
    Gaming)  "$0" remove-gaming ;;
  esac ;;

remove-browser)
  case "$(pick 'Remove Browser' 'Chrome' 'Brave' 'Edge' 'Firefox' 'Zen' 'Chromium')" in
    Chrome)   alacritty -e bash -c 'yay -Rns --noconfirm google-chrome 2>/dev/null || sudo pacman -Rns google-chrome; read -n1' ;;
    Brave)    alacritty -e bash -c 'yay -Rns --noconfirm brave-bin; read -n1' ;;
    Edge)     alacritty -e bash -c 'yay -Rns --noconfirm microsoft-edge-stable-bin; read -n1' ;;
    Firefox)  alacritty -e bash -c 'sudo pacman -Rns firefox; read -n1' ;;
    Zen)      alacritty -e bash -c 'yay -Rns --noconfirm zen-browser-bin; read -n1' ;;
    Chromium) alacritty -e bash -c 'sudo pacman -Rns chromium; read -n1' ;;
  esac ;;

remove-service)
  case "$(pick 'Remove Service' 'Dropbox' 'Tailscale' 'Spotify' 'Signal')" in
    Dropbox)   alacritty -e bash -c 'yay -Rns --noconfirm dropbox; read -n1' ;;
    Tailscale) alacritty -e bash -c 'sudo pacman -Rns tailscale; read -n1' ;;
    Spotify)   alacritty -e bash -c 'yay -Rns --noconfirm spotify 2>/dev/null; sudo pacman -Rns spotify-launcher 2>/dev/null; read -n1' ;;
    Signal)    alacritty -e bash -c 'sudo pacman -Rns signal-desktop 2>/dev/null; yay -Rns signal-desktop 2>/dev/null; read -n1' ;;
  esac ;;

remove-gaming)
  case "$(pick 'Remove Gaming' 'Steam' 'RetroArch' 'Minecraft' 'Lutris' 'Heroic')" in
    Steam)     alacritty -e bash -c 'sudo pacman -Rns steam; read -n1' ;;
    RetroArch) alacritty -e bash -c 'sudo pacman -Rns retroarch; read -n1' ;;
    Minecraft) alacritty -e bash -c 'yay -Rns --noconfirm minecraft-launcher 2>/dev/null; read -n1' ;;
    Lutris)    alacritty -e bash -c 'sudo pacman -Rns lutris; read -n1' ;;
    Heroic)    alacritty -e bash -c 'yay -Rns --noconfirm heroic-games-launcher-bin; read -n1' ;;
  esac ;;

about)
  alacritty -e bash -c 'fastfetch; echo; echo "arch-i3-minimal — https://github.com/abr60/arch-i3-minimal"; read -n1' ;;

system)
  case "$(pick 'System' 'Lock' 'Suspend' 'Hibernate' 'Logout' 'Reboot' 'Shutdown' 'Screensaver')" in
    Lock)        i3lock -c 1a1a1a ;;
    Suspend)     systemctl suspend ;;
    Hibernate)   systemctl hibernate 2>/dev/null || notify "System" "Hibernate not available" ;;
    Logout)      i3-msg exit ;;
    Reboot)      systemctl reboot ;;
    Shutdown)    systemctl poweroff ;;
    Screensaver) i3lock -c 1a1a1a ;;
  esac ;;

update)
  case "$(pick 'Update' 'System (pacman + yay)' 'Dotfiles (git pull)' 'Firmware (fwupdmgr)' 'Timezone' 'Time' 'Password')" in
    'System (pacman + yay)') alacritty -e bash -c "$REPO/update.sh; read -n1" ;;
    'Dotfiles (git pull)') alacritty -e bash -c "cd $REPO && git pull --rebase && ./setup.sh; read -n1" ;;
    'Firmware (fwupdmgr)') alacritty -e bash -c 'fwupdmgr refresh && fwupdmgr get-updates; read -n1' ;;
    Timezone) alacritty -e bash -c 'sudo tzselect 2>/dev/null || timedatectl list-timezones | rofi -dmenu -p Timezone | xargs -I{} sudo timedatectl set-timezone {}; read -n1' ;;
    Time) alacritty -e bash -c 'timedatectl status; read -n1' ;;
    Password) alacritty -e passwd ;;
  esac ;;
esac
