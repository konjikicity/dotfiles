#!/usr/bin/env bash
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')

ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
ctx_tokens=$(echo "$input" | jq -r '(.context_window.total_input_tokens // 0) + (.context_window.total_output_tokens // 0)')
ctx_limit=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')

RESET=$'\033[0m'
BOLD=$'\033[1m'
DIM=$'\033[2m'
CYAN=$'\033[36m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'
MAGENTA=$'\033[35m'

ctx_pct_int=$(printf "%.0f" "$ctx_pct")
if [ "$ctx_pct_int" -lt 50 ]; then
  ctx_color="$GREEN"
elif [ "$ctx_pct_int" -lt 80 ]; then
  ctx_color="$YELLOW"
else
  ctx_color="$RED"
fi

git_branch=""
if [ -n "$cwd" ] && [ -d "$cwd" ]; then
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
  if [ -n "$branch" ]; then
    git_branch="${MAGENTA} ${branch}${RESET}"
  fi
fi

fmt_k() {
  awk -v t="$1" 'BEGIN { if (t >= 1000) printf "%.1fk", t/1000; else printf "%d", t }'
}
ctx_tokens_fmt=$(fmt_k "$ctx_tokens")
ctx_limit_fmt=$(fmt_k "$ctx_limit")
cost_fmt=$(awk -v c="$cost_usd" 'BEGIN { printf "%.4f", c }')

sep="${DIM} | ${RESET}"
output="${CYAN}●${RESET} ${BOLD}${model}${RESET}"
[ -n "$git_branch" ] && output="${output}${sep}${git_branch}"
output="${output}${sep}${ctx_color}${ctx_pct_int}% (${ctx_tokens_fmt}/${ctx_limit_fmt})${RESET}"
output="${output}${sep}${GREEN}\$${cost_fmt}${RESET}"
if [ "$lines_added" -gt 0 ] || [ "$lines_removed" -gt 0 ]; then
  output="${output}${sep}${GREEN}+${lines_added}${RESET}/${RED}-${lines_removed}${RESET}"
fi

printf "%b" "$output"
