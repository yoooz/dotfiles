#!/usr/bin/env bash
# Claude Code の hook から呼ばれ、止まった/完了したときに macOS 通知を出す。
# Notification hook と Stop hook の両方から呼ばれる前提で、hook_event_name で分岐する。
set -euo pipefail

# hook は最小環境で実行されるため、Homebrew の bin を明示的に通す（terminal-notifier / jq）。
export PATH="/opt/homebrew/bin:${PATH}"

input=$(cat)
event=$(printf '%s' "$input" | jq -r '.hook_event_name // "unknown"')

case "$event" in
  Notification)
    # 例: "Claude needs your permission to use Bash" / アイドル時のメッセージ
    message=$(printf '%s' "$input" | jq -r '.message // "確認待ちです"')
    title="🔔 Claude Code — 確認待ち"
    ;;
  Stop)
    message="応答が完了しました"
    title="✅ Claude Code — 完了"
    ;;
  *)
    message="$event"
    title="Claude Code"
    ;;
esac

# -group で通知をまとめ、古い通知を新しいもので置き換える（通知が溜まらない）。
terminal-notifier \
  -title "$title" \
  -message "$message" \
  -sound Glass \
  -group claude-code
