#!/bin/zsh

# zplug
source ${HOME}/.zplug/init.zsh
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug load

# zstyles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both
zstyle ':completion:*' completer _complete _ignored _expand _match _prefix _list _history
zstyle ':completion:*' verbose no
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recend-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# Use modern completion system
autoload -Uz compinit
compinit

export LANG=ja_JP.UTF-8

# load colors
autoload -U colors
colors

# Use emacs keybindings
bindkey -e

# umask
umask 002

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=6000000
export SAVEHIST=6000000

setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt correct
setopt list_packed
setopt complete_in_word
setopt longlistjobs
setopt notify
setopt auto_param_slash
setopt mark_dirs
setopt auto_param_keys
setopt no_flow_control

# auto cd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# prompt
PROMPT="%{${fg[cyan]}%}%n %# %{${reset_color}%}"

if [[ -z $TMUX ]]; then
  eval "$(anyenv init - zsh)"
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
