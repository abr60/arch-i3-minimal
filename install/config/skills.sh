#!/bin/bash
# install/config/skills.sh — symlink agent skills to all agent directories (Omarchy pattern)
# Mirrors /usr/share/omarchy/migrations/1786098807.sh + 1787843905.sh
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/../lib/helpers.sh"
REPO="$(cd "$DIR/../.." && pwd)"
SKILL_SRC="$REPO/agents/skills/arch-i3-minimal"
if [[ ! -d $SKILL_SRC ]]; then log "No skill at $SKILL_SRC — skipping"; exit 0; fi
log "Linking agent skill → agent directories"
for d in "$HOME/.agents/skills" "$HOME/.claude/skills" "$HOME/.codex/skills" "$HOME/.pi/agent/skills"; do
  mkdir -p "$d"
  ln -sfn "$SKILL_SRC" "$d/arch-i3-minimal"
  ok "$(basename "$(dirname "$d")")/$(basename "$d")/arch-i3-minimal"
done
# Hermes (also per-profile)
mkdir -p "$HOME/.hermes/skills"
ln -sfn "$SKILL_SRC" "$HOME/.hermes/skills/arch-i3-minimal"
ok "hermes/skills/arch-i3-minimal"
if [[ -d $HOME/.hermes/profiles ]]; then
  for p in "$HOME"/.hermes/profiles/*/; do
    [[ -d $p ]] || continue
    mkdir -p "$p/skills"
    ln -sfn "$SKILL_SRC" "$p/skills/arch-i3-minimal"
  done
  ok "hermes profiles"
fi
