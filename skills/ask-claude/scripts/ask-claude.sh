#!/bin/bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: bash ask-claude.sh [project-directory] < consultation.txt

Claude に設計・コードの相談をする。プロジェクトの既定値は現在のディレクトリ。
相談文は標準入力、返答は標準出力。Claude は Read・Glob・Grep のみ利用できる。
モデルを指定する場合: ASK_CLAUDE_MODEL=... bash ask-claude.sh ...
USAGE
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi
if (( $# > 1 )); then
  usage >&2
  exit 2
fi
if [[ -n "${CLAUDECODE:-}" ]]; then
  echo "Error: このスクリプトは Codex から使ってください。Claude Code 内からの再帰呼び出しはできません。" >&2
  exit 2
fi
if ! command -v claude >/dev/null 2>&1; then
  echo "Error: Claude Code CLI (claude) が PATH にありません。" >&2
  exit 127
fi

project_dir="${1:-$PWD}"
if [[ ! -d "$project_dir" ]]; then
  echo "Error: プロジェクトディレクトリが存在しません: $project_dir" >&2
  exit 2
fi
if [[ -t 0 ]]; then
  echo "Error: 相談文を標準入力で渡してください。--help で使用方法を確認できます。" >&2
  exit 2
fi
consultation=$(cat)
if [[ ! "$consultation" =~ [^[:space:]] ]]; then
  echo "Error: 相談文が空です。" >&2
  exit 2
fi

claude_args=(
  --print
  --safe-mode
  --tools "Read,Glob,Grep"
  --allowedTools "Read,Glob,Grep"
  --permission-mode dontAsk
  --no-session-persistence
  --output-format text
  --append-system-prompt "あなたは Codex の相談相手として、設計・実装上の意思決定を独立に、批判的に検討します。日本語で回答してください。
Codex の案や説明を正しいと仮定せず、ユーザーの目的・制約、確認できる事実、Codex の解釈を区別してください。同意を求められても、根拠に基づいて判断してください。
結論に影響する前提の誤りや不足、具体的な反例・失敗条件、最も強い反論を検討してください。相談内容に応じて正しさ、互換性、性能、保守性などのトレードオフを比較し、より単純な代替案や、将来どの変更で案が破綻するかを示してください。
対象コードを必要に応じて読み、重要な指摘にはファイル名・行番号、具体例などの根拠を添えてください。未確認の推測は事実と区別し、情報が足りなければ結論が変わる条件や追加で確認すべきことを示してください。
批判のために欠点を捏造したり、無理に代替案を増やしたりしないでください。案が妥当なら、その理由と成立条件を説明してください。重要な論点を優先し、推奨する判断とその根拠を明確にしてください。
担当は読み取りと助言のみです。ファイル編集、コマンド実行、他エージェントへの委任は行いません。"
)
if [[ -n "${ASK_CLAUDE_MODEL:-}" ]]; then
  claude_args+=(--model "$ASK_CLAUDE_MODEL")
fi

cd -- "$project_dir"
exec claude "${claude_args[@]}" <<< "$consultation"
