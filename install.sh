#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

ln -s ${SCRIPT_DIR}/emacs.d ${HOME}/.emacs.d
ln -s ${SCRIPT_DIR}/zshrc ${HOME}/.zshrc
ln -s ${SCRIPT_DIR}/tmux.conf ${HOME}/.tmux.conf
ln -s ${SCRIPT_DIR}/peco ${HOME}/.config/peco
ln -s ${SCRIPT_DIR}/ideavimrc ${HOME}/.ideavimrc
ln -s ${SCRIPT_DIR}/vimrc ${HOME}/.vimrc
ln -s ${SCRIPT_DIR}/tmux-pane-border ${HOME}/bin/tmux-pane-border
