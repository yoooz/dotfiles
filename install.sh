#!/bin/bash

SCRIPT_DIR=$(
  cd $(dirname $0)
  pwd
)

ln -s ${SCRIPT_DIR}/zshrc ${HOME}/.zshrc
ln -s ${SCRIPT_DIR}/tmux.conf ${HOME}/.tmux.conf
ln -s ${SCRIPT_DIR}/tmux-powerline ${HOME}/.config/tmux-powerline
ln -s ${SCRIPT_DIR}/ideavimrc ${HOME}/.ideavimrc
ln -s ${SCRIPT_DIR}/vimrc ${HOME}/.vimrc
ln -s ${SCRIPT_DIR}/lazygit_config.yml ${HOME}/Library/Application\ Support/lazygit/config.yml
