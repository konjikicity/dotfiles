#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link() {
  local src="$1"
  local dest="$2"
  local rel="${dest#"$HOME"/}"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    mv "$dest" "$BACKUP_DIR/$rel"
    echo "backup: $dest -> $BACKUP_DIR/$rel"
  fi
  ln -sfn "$src" "$dest"
  echo "link:   $dest -> $src"
}

# claude
link "$DOTFILES_DIR/claude/settings.json"                 "$CLAUDE_DIR/settings.json"
link "$DOTFILES_DIR/claude/CLAUDE.md"                     "$CLAUDE_DIR/CLAUDE.md"
link "$DOTFILES_DIR/claude/statusline-command.sh"         "$CLAUDE_DIR/statusline-command.sh"
link "$DOTFILES_DIR/claude/commands/hard-review.md"       "$CLAUDE_DIR/commands/hard-review.md"
link "$DOTFILES_DIR/claude/plugins/known_marketplaces.json" "$CLAUDE_DIR/plugins/known_marketplaces.json"

# home（$HOME 直下）
for f in .zshrc .zprofile .zshenv .p10k.zsh .fzf.zsh \
         .gitconfig .gitignore_global .tmux.conf .tmux-powerlinerc; do
  link "$DOTFILES_DIR/home/$f" "$HOME/$f"
done

# home（.config 配下・アプリ単位）
for d in alacritty ghostty karabiner peco tmux-powerline git psysh nvim; do
  link "$DOTFILES_DIR/home/.config/$d" "$HOME/.config/$d"
done
link "$DOTFILES_DIR/home/.config/starship.toml" "$HOME/.config/starship.toml"

echo "done."
