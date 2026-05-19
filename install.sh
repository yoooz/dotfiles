#!/bin/bash

SCRIPT_DIR=$(
  cd $(dirname $0)
  pwd
)

ln -sf ${SCRIPT_DIR}/zshrc ${HOME}/.zshrc
ln -sf ${SCRIPT_DIR}/tmux.conf ${HOME}/.tmux.conf
ln -sf ${SCRIPT_DIR}/tmux-powerline ${HOME}/.config/tmux-powerline
ln -sf ${SCRIPT_DIR}/nvim ${HOME}/.config/nvim
ln -sf ${SCRIPT_DIR}/ideavimrc ${HOME}/.ideavimrc
ln -sf ${SCRIPT_DIR}/vimrc ${HOME}/.vimrc
ln -sf ${SCRIPT_DIR}/lazygit_config.yml ${HOME}/Library/Application\ Support/lazygit/config.yml
ln -sf ${SCRIPT_DIR}/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ${SCRIPT_DIR}/claude/scripts ~/.claude/scripts
ln -sf ${SCRIPT_DIR}/claude/settings.json ~/.claude/settings.json
ln -sf ${SCRIPT_DIR}/gitignore_global ~/.config/git/ignore
ln -sf ${SCRIPT_DIR}/ghostty ~/.config/ghostty
ln -sf ${SCRIPT_DIR}/sketchybar ~/.config/sketchybar
ln -sf ${SCRIPT_DIR}/aerospace ~/.config/aerospace

# Claude Code agent skills (自作カスタムskillを個別に symlink)
mkdir -p ~/.claude/skills
for skill_dir in ${SCRIPT_DIR}/claude/skills/*/; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename "$skill_dir")
  ln -sfn "$skill_dir" ~/.claude/skills/"$skill_name"
done
