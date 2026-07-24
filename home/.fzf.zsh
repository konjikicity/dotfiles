# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/onodaosamu/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/onodaosamu/.fzf/bin"
fi

source <(fzf --zsh)
