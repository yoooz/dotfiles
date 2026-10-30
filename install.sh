#!/bin/bash

SCRIPT_DIR=$(
  cd $(dirname $0)
  pwd
)

ln -sf ${SCRIPT_DIR}/zshrc ${HOME}/.zshrc
mkdir -p ${HOME}/.config/herdr
ln -sf ${SCRIPT_DIR}/herdr/config.toml ${HOME}/.config/herdr/config.toml
ln -sfn ${SCRIPT_DIR}/nvim ${HOME}/.config/nvim
ln -sf ${SCRIPT_DIR}/ideavimrc ${HOME}/.ideavimrc
ln -sf ${SCRIPT_DIR}/vimrc ${HOME}/.vimrc
ln -sf ${SCRIPT_DIR}/lazygit_config.yml ${HOME}/Library/Application\ Support/lazygit/config.yml
mkdir -p "${HOME}/.claude" "${CODEX_HOME:-${HOME}/.codex}"
ln -sfn "${SCRIPT_DIR}/ai/AGENTS.md" "${HOME}/.claude/CLAUDE.md"
ln -sfn "${SCRIPT_DIR}/ai/AGENTS.md" "${CODEX_HOME:-${HOME}/.codex}/AGENTS.md"
# Git に保存する内容から Codex のローカルな projects だけを除外する。
git -C "${SCRIPT_DIR}" config --local filter.codex-config.clean 'python3 ai/codex/filter-config.py' || exit 1
git -C "${SCRIPT_DIR}" config --local filter.codex-config.required true || exit 1
ln -sfn "${SCRIPT_DIR}/ai/codex/config.toml" "${CODEX_HOME:-${HOME}/.codex}/config.toml"
ln -sfn "${SCRIPT_DIR}/ai/claude/scripts" "${HOME}/.claude/scripts"
ln -sfn "${SCRIPT_DIR}/ai/claude/settings.json" "${HOME}/.claude/settings.json"
ln -sf ${SCRIPT_DIR}/gitignore_global ~/.config/git/ignore
if [[ "$(uname -s)" == "Linux" ]] && command -v omarchy >/dev/null 2>&1; then
  mkdir -p "${HOME}/.config/omarchy"
  ln -sfn "${SCRIPT_DIR}/omarchy/shell.json" "${HOME}/.config/omarchy/shell.json"
  mkdir -p "${HOME}/.config/omarchy/plugins"
  for plugin_dir in "${SCRIPT_DIR}"/omarchy/plugins/*/; do
    [ -d "$plugin_dir" ] || continue
    ln -sfn "${plugin_dir%/}" "${HOME}/.config/omarchy/plugins/$(basename "$plugin_dir")"
  done
  mkdir -p "${HOME}/.config/hypr"
  ln -sfn "${SCRIPT_DIR}/hypr/monitors.lua" "${HOME}/.config/hypr/monitors.lua"
  ln -sfn "${SCRIPT_DIR}/hypr/input.lua" "${HOME}/.config/hypr/input.lua"
  ln -sfn "${SCRIPT_DIR}/hypr/autostart.lua" "${HOME}/.config/hypr/autostart.lua"
  mkdir -p "${HOME}/.config/ghostty"
  ln -sfn "${SCRIPT_DIR}/ghostty/config.omarchy" "${HOME}/.config/ghostty/config"
  mkdir -p "${HOME}/.config/systemd/user/app-com.mitchellh.ghostty.service.d"
  ln -sfn "${SCRIPT_DIR}/ghostty/systemd/override.conf" "${HOME}/.config/systemd/user/app-com.mitchellh.ghostty.service.d/override.conf"
else
  ln -sfn "${SCRIPT_DIR}/ghostty" "${HOME}/.config/ghostty"
fi
ln -sfn ${SCRIPT_DIR}/sketchybar ~/.config/sketchybar
ln -sfn ${SCRIPT_DIR}/aerospace ~/.config/aerospace

# 自作カスタムskillを個別に symlink。相談用以外は両エージェントで共有。
mkdir -p "${HOME}/.claude/skills" "${HOME}/.agents/skills" "${CODEX_HOME:-${HOME}/.codex}/skills"
for skill_dir in "${SCRIPT_DIR}"/skills/*/; do
  [ -f "${skill_dir}SKILL.md" ] || continue
  skill_name=$(basename "$skill_dir")
  if [ "$skill_name" != "ask-codex" ]; then
    ln -sfn "$skill_dir" "${HOME}/.agents/skills/$skill_name"
    ln -sfn "$skill_dir" "${CODEX_HOME:-${HOME}/.codex}/skills/$skill_name"
  fi
  if [ "$skill_name" != "ask-claude" ]; then
    ln -sfn "$skill_dir" "${HOME}/.claude/skills/$skill_name"
  fi
done
