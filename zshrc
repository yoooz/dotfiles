# run tmux
#[[ -z "$TMUX" && ! -z "$PS1" ]] && exec tmux

# zplug
source ${HOME}/.zplug/init.zsh

zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zaw'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug load

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

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

# load colors
autoload -U colors
colors

# Use modern completion system
autoload -Uz compinit
compinit

export LANG=ja_JP.UTF-8
if [[ -z $TMUX ]]; then
    export PATH=$PATH:/opt/maven/bin:${HOME}/bin
    export PATH=$PATH:/usr/local/bin
    export PATH=$PATH:${HOME}/.anyenv/bin
    export PATH=$PATH:${GOPATH}/bin
fi 
eval "$(anyenv init -)"

export EDITOR=emacs

case "${OSTYPE}" in
    darwin*)
	alias ls='exa'
	alias ll='exa -l'
	alias la='exa -a'
    alias pidcat='pidcat --always-display-tags'
    if [[ -z $TMUX ]]; then
    	export PATH=$PATH:${HOME}/Library/Android/sdk/platform-tools/:${HOME}/Library/Android/sdk/tools/
        export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home
    fi 
	;;
    linux*)
	alias ls='ls --color=auto'
	alias ll='ls -l --color=auto'
	alias la='ls -a --color=auto'
	alias pbcopy='xsel --clipboard --input'
	alias pbpaste='xsel --clipboard --output'
    alias hhkb='sudo dpkg-reconfigure keyboard-configuration'
    if [[ -z $TMUX ]]; then
        export PATH=$PATH:${HOME}/tmp/swift-DEVELOPMENT-SNAPSHOT-2018-09-08-a-ubuntu18.04/usr/bin
    	export PATH=$PATH:${HOME}/workspace/android-practice/Sdk/platform-tools
    	export PATH=$PATH:${HOME}/workspace/android-practice/Sdk/tools
    fi
	;;
esac

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=6000000
export SAVEHIST=6000000

# ls color
export LS_COLORS='no=32:di=36:ln=35:so=37:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30:*.pdf=33'

# Install Node.js
export NVM_DIR=${HOME}/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Use emacs keybindings
bindkey -e

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

# alias
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias j=jobs
alias h=history
alias grep=egrep
alias cat='bat'
alias e='emacsclient -t'
alias gcd='cd $(ghq root)/$(ghq list | peco --prompt "REPOSITORY")'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias gclone='ghq get'
alias gjump='git checkout $(git branch | sed "s/*//g" | sed "s/ //g" | peco --prompt "GIT BRANCH")'
alias psh='ssh `grep "Host " ~/.ssh/config | grep -v "\*" | cut -b 6- | peco --prompt "HOST> "`'

# umask
umask 002

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

function peco-kill() {
    for pid in `ps aux | peco --prompt "TARGET PROCESS> "| awk '{ print $2 }'`
    do
        kill $pid
        echo "Killed ${pid}"
    done
}
alias pk="peco-kill"

function peco-cdr() {
    local selected_dir=$(cdr -l | awk '{print $2 }' | peco --prompt "CHANGE DIRECTOY> ")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    else
        zle reset-prompt
    fi
    zle clear-screen
}
zle -N peco-cdr
bindkey '^S' peco-cdr

function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
