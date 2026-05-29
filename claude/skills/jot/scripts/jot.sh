#!/bin/bash
set -euo pipefail

MESSAGE="${1:-}"
if [ -z "$MESSAGE" ]; then
    echo "Error: メッセージが指定されていません" >&2
    echo "Usage: $0 <message>" >&2
    exit 1
fi

VAULT_DIR="${YOOOZ_VAULT_DIR:-$HOME/yoooz_vault}"
YEAR=$(date '+%Y')
MONTH=$(date '+%m')
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')

DAILY_NOTE="$VAULT_DIR/daily_notes/$YEAR/$MONTH/$DATE.md"

if [ ! -f "$DAILY_NOTE" ]; then
    echo "Error: 今日のデイリーノートが存在しない: $DAILY_NOTE" >&2
    exit 1
fi

if [ -n "$(tail -c1 "$DAILY_NOTE")" ]; then
    printf '\n' >> "$DAILY_NOTE"
fi

ENTRY="- $TIME $MESSAGE"
printf '%s\n' "$ENTRY" >> "$DAILY_NOTE"
echo "Added to $DAILY_NOTE:"
echo "$ENTRY"
