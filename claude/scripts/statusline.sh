#!/usr/bin/env bash
# Claude Code の statusLine 用スクリプト。stdin に渡される JSON から
# モデル名 / ディレクトリ / git ブランチ / context 使用量 / コスト を 1 行で表示する。
# context 使用率はバー＋色（緑<70% / 黄70-89% / 赤90%+）で可視化する。
set -euo pipefail
export PATH="/opt/homebrew/bin:${PATH}"

input=$(cat)
j() { printf '%s' "$input" | jq -r "$1"; }

# --- 値の取り出し ---
model=$(j '.model.display_name // "Claude"')
dir=$(j '.workspace.current_dir // .cwd // ""')
dir_name=$(basename "$dir" 2>/dev/null || echo "")
cost=$(j '.cost.total_cost_usd // 0')

ctx_pct=$(j '.context_window.used_percentage // empty')
ctx_size=$(j '.context_window.context_window_size // 0')
ctx_in=$(j '.context_window.total_input_tokens // 0')

# git ブランチ（軽い rev-parse のみ。リポジトリでなければ空）
branch=""
if [[ -n "$dir" ]]; then
  branch=$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
fi

# --- ANSI カラー ---
RESET=$'\033[0m'; DIM=$'\033[2m'
GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'; CYAN=$'\033[36m'

# --- トークン数を読みやすい単位に ---
human_k() { # 引数: トークン数 → "180k" / "1M"
  local n=$1
  if (( n >= 1000000 )); then
    printf '%dM' $(( n / 1000000 ))
  else
    printf '%dk' $(( n / 1000 ))
  fi
}

# --- context 表示（バー＋%＋トークン） ---
if [[ -n "$ctx_pct" ]]; then
  pct_int=${ctx_pct%.*}            # 小数切り捨て
  [[ -z "$pct_int" ]] && pct_int=0
  if   (( pct_int >= 90 )); then col=$RED
  elif (( pct_int >= 70 )); then col=$YELLOW
  else                            col=$GREEN
  fi
  # 10 段バー
  filled=$(( (pct_int + 9) / 10 ))
  (( filled > 10 )) && filled=10
  (( filled < 0 ))  && filled=0
  bar=""
  for ((i = 0; i < 10; i++)); do
    if (( i < filled )); then bar+="▰"; else bar+="▱"; fi
  done
  ctx_display="${col}ctx ${bar} ${pct_int}%${RESET} ${DIM}($(human_k "$ctx_in")/$(human_k "$ctx_size"))${RESET}"
else
  ctx_display="${DIM}ctx --${RESET}"
fi

# --- 組み立て ---
line="${CYAN}${model}${RESET}"
[[ -n "$dir_name" ]] && line+="  ${DIM}${dir_name}${RESET}"
[[ -n "$branch"   ]] && line+="  ${DIM}⎇ ${branch}${RESET}"
line+="  │ ${ctx_display}"
line+="  ${DIM}│ \$$(printf '%.2f' "$cost")${RESET}"

printf '%s' "$line"
