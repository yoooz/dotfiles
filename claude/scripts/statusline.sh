#!/usr/bin/env bash
# Claude Code の statusLine 用スクリプト。stdin に渡される JSON から
# モデル名 / ディレクトリ / git ブランチ / context 使用量 / プラン枠(レート制限) を 1 行で表示する。
# context 使用率はバー＋色（緑<70% / 黄70-89% / 赤90%+）で可視化する。
set -euo pipefail
export PATH="/opt/homebrew/bin:${PATH}"

input=$(cat)
j() { printf '%s' "$input" | jq -r "$1"; }

# --- 値の取り出し ---
model=$(j '.model.display_name // "Claude"')
dir=$(j '.workspace.current_dir // .cwd // ""')
dir_name=$(basename "$dir" 2>/dev/null || echo "")

ctx_pct=$(j '.context_window.used_percentage // empty')
ctx_size=$(j '.context_window.context_window_size // 0')
ctx_in=$(j '.context_window.total_input_tokens // 0')

# レート制限（Claude.ai Pro/Max のみ・最初の API 応答後に出現。無ければ空）
rl_5h_pct=$(j '.rate_limits.five_hour.used_percentage // empty')
rl_5h_reset=$(j '.rate_limits.five_hour.resets_at // empty')
rl_7d_pct=$(j '.rate_limits.seven_day.used_percentage // empty')
rl_7d_reset=$(j '.rate_limits.seven_day.resets_at // empty')

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

# --- 使用率 → 色（緑<70 / 黄70-89 / 赤90+） ---
pct_color() { # 引数: パーセント(小数可) → ANSI 色
  local p=${1%.*}; [[ -z "$p" ]] && p=0
  if   (( p >= 90 )); then printf '%s' "$RED"
  elif (( p >= 70 )); then printf '%s' "$YELLOW"
  else                     printf '%s' "$GREEN"
  fi
}

# --- レート制限 1 枠分を組み立て ---
# 引数: ラベル, 使用率, resets_at(epoch), 時刻フォーマット → "5h 23%→15:00"（色付き）
rl_seg() {
  local label=$1 pct=$2 reset=$3 fmt=$4
  [[ -z "$pct" ]] && return 0
  local p=${pct%.*}; [[ -z "$p" ]] && p=0
  local t=""
  if [[ -n "$reset" ]]; then
    t="→$(date -r "${reset%.*}" +"$fmt" 2>/dev/null)"
  fi
  printf '%s%s %d%%%s%s' "$(pct_color "$pct")" "$label" "$p" "$t" "$RESET"
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

# --- レート制限表示（5h は時刻、7d は日付。両方無ければ空） ---
seg_5h=$(rl_seg "5h" "$rl_5h_pct" "$rl_5h_reset" "%H:%M")
seg_7d=$(rl_seg "7d" "$rl_7d_pct" "$rl_7d_reset" "%m/%d")
rl_display=""
[[ -n "$seg_5h" ]] && rl_display="$seg_5h"
[[ -n "$seg_7d" ]] && rl_display="${rl_display:+$rl_display ${DIM}·${RESET} }$seg_7d"

# --- 組み立て ---
line="${CYAN}${model}${RESET}"
[[ -n "$dir_name" ]] && line+="  ${DIM}${dir_name}${RESET}"
[[ -n "$branch"   ]] && line+="  ${DIM}⎇ ${branch}${RESET}"
line+="  │ ${ctx_display}"
[[ -n "$rl_display" ]] && line+="  ${DIM}│${RESET} ${rl_display}"

printf '%s' "$line"
