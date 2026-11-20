#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
CONFIG_DIR="${HOME}/.gemini/antigravity-cli"

# CLI が保存する trustedWorkspaces などは端末に残し、管理対象だけ上書きする。
python3 - "$SCRIPT_DIR" "$CONFIG_DIR" <<'PY'
import json
import shutil
import sys
from pathlib import Path

source, destination = map(Path, sys.argv[1:])
settings_path = destination / "settings.json"
settings = json.loads(settings_path.read_text()) if settings_path.exists() else {}
managed = json.loads((source / "settings.json").read_text())
settings.update(managed)

destination.mkdir(parents=True, exist_ok=True)
script_path = destination / "statusline.py"
if script_path.exists() and not script_path.is_symlink():
    sys.exit(f"既存のスクリプトがあるため中止: {script_path}")
if script_path.is_symlink():
    script_path.unlink()
script_path.symlink_to(source / "statusline.py")

if settings_path.exists():
    shutil.copy2(settings_path, destination / "settings.json.bak")
settings_path.write_text(json.dumps(settings, ensure_ascii=False, indent=2) + "\n")
print(f"Antigravity のステータスラインを設定: {settings_path}")
PY

# SCRIPT_DIR は絶対パス。リンクを置くディレクトリからの相対解釈を避ける。
ln -sfn "${SCRIPT_DIR}/../AGENTS.md" "${HOME}/.gemini/AGENTS.md"

SKILLS_DIR=$(cd "${SCRIPT_DIR}/../../skills" && pwd)
mkdir -p "${HOME}/.gemini/config/skills"
for skill_name in ask-codex ask-claude; do
  ln -sfn "${SKILLS_DIR}/${skill_name}" "${HOME}/.gemini/config/skills/${skill_name}"
done
