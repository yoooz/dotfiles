#!/bin/zsh

source ${HOME}/.zplug/init.zsh

# zplug
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
setopt list_packed
setopt complete_in_word
setopt longlistjobs
setopt notify
setopt auto_param_slash
setopt mark_dirs
setopt auto_param_keys
setopt no_flow_control
unsetopt correctall
unsetopt correct

# auto cd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# prompt
#PROMPT="%{${fg_bold[cyan]}%}> %{${reset_color}%}"
if [ ${UID} -eq 0 ]; then
  PROMPT="%K{green}%B%F{black}ROOT%b%k %F{cyan}%~ %f$ "
else
  UUU="%B%F{cyan}（」・ω・）」❯ %f%b"
  NYA="%B%F{cyan}\（・ω・\）%f%b"
  SAN="%B%F{red}＼（・ω・＼）❯ %f%b"
  PIN="%B%F{red}（／・ω・）／%f%b"
  PROMPT="%(?,${UUU},${SAN})"
  RPROMPT="%(?,${NYA},${PIN})"
fi

eval "$(anyenv init - zsh)"
export PATH=/opt/maven/bin:${HOME}/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=${HOME}/.anyenv/bin:$PATH
export GOPATH=$HOME/go

# なんかおかしい
export PATH=${GOPATH}/bin:$PATH
export JAVA_HOME=`jenv javahome`

case "${OSTYPE}" in
    darwin*)
        export PATH=$PATH:${HOME}/Library/Android/sdk/platform-tools/
        export PATH=$PATH:${HOME}/Library/Android/sdk/tools/
        ;;
    linux*)
        export PATH=$PATH:${HOME}/workspace/android-practice/Sdk/platform-tools
        export PATH=$PATH:${HOME}/workspace/android-practice/Sdk/tools
        ;;
esac

case "${OSTYPE}" in
    darwin*)
	alias pidcat='pidcat --always-display-tags'
	;;
    linux*)
	alias pbcopy='xsel --clipboard --input'
	alias pbpaste='xsel --clipboard --output'
  alias hhkb='sudo dpkg-reconfigure keyboard-configuration'
	;;
esac

# alias
alias ls='ls -GF'
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
alias gc='cd $(ghq root)/$(ghq list | peco --prompt "REPOSITORY >")'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias gg='ghq get'
alias gj='git checkout $(git branch | sed "s/*//g" | sed "s/ //g" | peco --prompt "CHECKOUT BRANCH >")'
alias gp='git pull'
alias gm='git branch | grep -v "\*" | peco --prompt "MERGE BRANCH >"| xargs git merge'
alias gdel='git branch -D $(git branch | peco --prompt "DELETE BRANCH >")'
alias psh='ssh `grep "Host " ~/.ssh/config | grep -v "\*" | cut -b 6- | peco --prompt "HOST > "`'
alias fd='cd "$(find . -type d | peco)"'
alias ff='find . -name "*${1}*" | grep -v "/\." | peco'

# peco + history
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER" --prompt "COMMAND> ")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# peco + ps + kill
function peco-kill() {
    for pid in `ps aux | peco --prompt "TARGET PROCESS> "| awk '{ print $2 }'`
    do
        kill $pid
        echo "Killed ${pid}"
    done
}
alias pk="peco-kill"

function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
