#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$HOME/.claude/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR/$(dirname "${dest#"$CLAUDE_DIR"/}")"
    mv "$dest" "$BACKUP_DIR/${dest#"$CLAUDE_DIR"/}"
    echo "backup: $dest -> $BACKUP_DIR/${dest#"$CLAUDE_DIR"/}"
  fi
  ln -sfn "$src" "$dest"
  echo "link:   $dest -> $src"
}

link "$DOTFILES_DIR/claude/settings.json"                 "$CLAUDE_DIR/settings.json"
link "$DOTFILES_DIR/claude/CLAUDE.md"                     "$CLAUDE_DIR/CLAUDE.md"
link "$DOTFILES_DIR/claude/statusline-command.sh"         "$CLAUDE_DIR/statusline-command.sh"
link "$DOTFILES_DIR/claude/commands/hard-review.md"       "$CLAUDE_DIR/commands/hard-review.md"
link "$DOTFILES_DIR/claude/plugins/known_marketplaces.json" "$CLAUDE_DIR/plugins/known_marketplaces.json"

echo "done."
