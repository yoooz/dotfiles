#!/bin/bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: bash ask-codex.sh [project-directory] < consultation.txt

Codex に設計・コードの相談をする。プロジェクトの既定値は現在のディレクトリ。
相談文は標準入力、返答は標準出力。Codex は読み取り専用サンドボックスで動く。
モデルを指定する場合: ASK_CODEX_MODEL=... bash ask-codex.sh ...
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
# Codex のセッション内、または ask-claude 経由で起動された Claude からの呼び出しは、
# Claude と Codex が互いに相談し合う再帰になるため拒否する。
if [[ -n "${CODEX_SESSION_ID:-}" || -n "${CODEX_THREAD_ID:-}" || -n "${ASK_CLAUDE:-}" ]]; then
  echo "Error: このスクリプトは Claude Code から使ってください。Codex 内からの再帰呼び出しはできません。" >&2
  exit 2
fi
if ! command -v codex >/dev/null 2>&1; then
  echo "Error: Codex CLI (codex) が PATH にありません。" >&2
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

# 位置引数が役割の指示、標準入力が <stdin> ブロックとして末尾に連結される。
framing="あなたは Claude Code の相談相手として、設計・実装上の意思決定を独立に、批判的に検討します。日本語で回答してください。相談内容は末尾の <stdin> ブロックです。
Claude の案や説明を正しいと仮定せず、ユーザーの目的・制約、確認できる事実、Claude の解釈を区別してください。同意を求められても、根拠に基づいて判断してください。
結論に影響する前提の誤りや不足、具体的な反例・失敗条件、最も強い反論を検討してください。相談内容に応じて正しさ、互換性、性能、保守性などのトレードオフを比較し、より単純な代替案や、将来どの変更で案が破綻するかを示してください。
対象コードを必要に応じて読み、重要な指摘にはファイル名・行番号、具体例などの根拠を添えてください。未確認の推測は事実と区別し、情報が足りなければ結論が変わる条件や追加で確認すべきことを示してください。
批判のために欠点を捏造したり、無理に代替案を増やしたりしないでください。案が妥当なら、その理由と成立条件を説明してください。重要な論点を優先し、推奨する判断とその根拠を明確にしてください。
担当は読み取りと助言のみです。ファイル編集、コマンド実行による状態変更、他エージェントやスキルへの委任は行いません。"

output_file=""
stderr_file=""
trap 'rm -f -- ${output_file:+"$output_file"} ${stderr_file:+"$stderr_file"}' EXIT
output_file=$(mktemp)
stderr_file=$(mktemp)

codex_args=(
  exec
  --sandbox read-only
  --ephemeral
  --skip-git-repo-check
  --color never
  --output-last-message "$output_file"
)
if [[ -n "${ASK_CODEX_MODEL:-}" ]]; then
  codex_args+=(--model "$ASK_CODEX_MODEL")
fi

# Codex が起動するシェルへ伝わり、ask-claude.sh 側の再帰ガードが検知する。
export ASK_CODEX=1

cd -- "$project_dir"
set +e
codex "${codex_args[@]}" "$framing" <<< "$consultation" >/dev/null 2>"$stderr_file"
status=$?
set -e

if (( status != 0 )); then
  cat "$stderr_file" >&2
  exit "$status"
fi
if [[ ! -s "$output_file" ]]; then
  echo "Error: Codex から返答を取得できませんでした。" >&2
  cat "$stderr_file" >&2
  exit 1
fi
cat "$output_file"
