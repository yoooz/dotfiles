#!/bin/zsh

export LIBRARY_PATH="/usr/local/opt/libgccjit/lib/gcc/current:/usr/local/opt/gcc/lib/gcc/current:/usr/local/opt/gcc/lib/gcc/current/gcc/x86_64-apple-darwin21/12"

# zstyles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both
zstyle ':completion:*' completer _complete _ignored _expand _match _prefix _list _history
zstyle ':completion:*' verbose no
zstyle ':completion:*' recent-dirs-insert both
zstyle ':completion:*' list-separator '-->'
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recend-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

# prompt
UUU="%B%F{cyan}❯ %f%b"
SAN="%B%F{red}❯ %f%b"
PROMPT="%(?,${UUU},${SAN})"

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
export HISTSIZE=1000
export SAVEHIST=100000

setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history
setopt list_packed
setopt complete_in_word
setopt longlistjobs
setopt notify
setopt auto_param_slash
setopt mark_dirs
setopt auto_param_keys
setopt no_flow_control
setopt auto_menu
setopt auto_param_keys
setopt interactive_comments
setopt magic_equal_subst
setopt hist_expand
unsetopt correctall
unsetopt correct

bindkey "^I" menu-complete

# auto cd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# brew
test -e "/opt/homebrew/bin/brew" && eval "$(/opt/homebrew/bin/brew shellenv)"

# path
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
export PATH=${HOME}/bin:$PATH
export PATH=${HOME}/Library/Android/sdk/platform-tools:$PATH
export PATH=${HOME}/Library/Android/sdk/tools:$PATH
export PATH=${HOME}/bin/flutter/bin:$PATH

eval "$(anyenv init - zsh)"
export PATH=${HOME}/.anyenv/bin:$PATH
export PATH=${HOME}/.cargo/bin:$PATH

# pyenv
export PYENV_ROOT="$(anyenv root)/envs/pyenv"
eval "$(pyenv init --path)"

export PATH=$(go env GOPATH)/bin:$PATH
# volta
export VOLTA_HOME=${HOME}/.volta
export PATH=${VOLTA_HOME}/bin:${PATH}

# frum
eval "$(frum init)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
    

# alias
alias ls='exa'
alias ll='exa -l'
alias la='exa -a'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias j=jobs
alias h=history
alias grep=egrep
alias cat='bat'
alias e='emacsclient -t'
alias gc='cd $(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")'
alias gg='ghq get'
alias gj='git checkout $(git branch -a | grep -v "\->" | sed "s/*//g" | sed "s/ //g" | sed "s/remotes\/origin\///g" | sort -u | fzf)'
alias gp='git pull'
alias gm='git branch | grep -v "\*" | fzf | xargs git merge'
alias gdel='git branch -D $(git branch | grep -v "\*" | fzf)'
alias psh='ssh `grep "Host " ~/.ssh/config | grep -v "\*" | cut -b 6- | fzf`'
alias fd='cd "$(find . -type d | fzf)"'
alias ff='find . -name "*${1}*" | grep -v "/\." | fzf'
alias vf='vim `ff`'
alias tp='tmux popup'
alias pidcat='pidcat --always-display-tags'

# peco + history
function fzf-select-history() {
    BUFFER=$(\history -n -r 1 |  fzf --query "$LBUFFER")
    CURSOR=$#BUFFER
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# peco + ps + kill
function fzf-kill() {
    for pid in `ps aux | fzf | awk '{ print $2 }'`
    do
        kill $pid
        echo "Killed ${pid}"
    done
}
alias fk="fzf-kill"

function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

# if integrations not installed, this script failure exit
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

