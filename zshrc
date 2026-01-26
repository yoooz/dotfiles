#!/bin/zsh

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
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${HOME}/.local/bin:$PATH
export PATH=${HOME}/bin:$PATH
export PATH=${HOME}/Library/Android/sdk/platform-tools:$PATH
export PATH=${HOME}/Library/Android/sdk/tools:$PATH
export PATH=${HOME}/.rbenv/bin:$PATH
export PATH="/opt/homebrew/opt/mysql-client@8.0/bin:$PATH"

eval "$(rbenv init -)"

# neovim
export PATH=${PATH}:/opt/nvim

# go
export PATH=${PATH}:/usr/local/go/bin
export PATH=$(go env GOPATH)/bin:$PATH

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
    

# sdkman
source "$HOME/.sdkman/bin/sdkman-init.sh"

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# alias
alias ls='eza'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias grep=egrep
alias cat='bat'
alias gg='ghq get'
alias vim='nvim'

# peco + history
function fzf-select-history() {
    BUFFER=$(history -n -r 1 |  fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

eval "$(direnv hook zsh)"

# if integrations not installed, this script failure exit
if test -e "${HOME}/.iterm2_shell_integration.zsh";then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi

# ghq + fzf repository selector
function ghq-fzf() {
  local selected_dir=$(ghq list | fzf --preview "eza --tree --level=1 --color=always $(ghq root)/{}")
  if [ -n "$selected_dir" ]; then
    cd "$(ghq root)/$selected_dir"
  fi
}

# ghq + fzf alias
alias gf='ghq-fzf'

# git worktree create and cd
function git-worktree-cd() {
  if [ $# -eq 0 ]; then
    echo "Usage: git-worktree-cd <branch-name>"
    return 1
  fi
  
  local branch_name="$1"
  
  # Get current repository root directory name
  local repo_name=$(basename "$(git rev-parse --show-toplevel)")
  
  # Create worktree path in ghq structure
  local worktree_path="$(ghq root)/${repo_name}-${branch_name}"
  
  # Check if branch exists
  if git show-ref --verify --quiet "refs/heads/$branch_name"; then
    # Branch exists, just add worktree
    git worktree add "$worktree_path" "$branch_name" && cd "$worktree_path"
  else
    # Branch doesn't exist, create it
    git worktree add -b "$branch_name" "$worktree_path" && cd "$worktree_path"
  fi
}

# git worktree alias
alias gwc='git-worktree-cd'

# git worktree remove with fzf
function git-worktree-remove() {
  # Check if in a git repository
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not in a git repository"
    return 1
  fi
  
  # Get worktree list with path, commit hash and branch
  local worktrees=$(git worktree list | grep -v "(bare)")
  
  # Check if there are worktrees to remove
  if [ -z "$worktrees" ]; then
    echo "No worktrees found"
    return 1
  fi
  
  # Select worktree with fzf (showing full info)
  local selected=$(echo "$worktrees" | fzf --no-preview)
  
  # Extract path from selection
  if [ -n "$selected" ]; then
    local worktree_path=$(echo "$selected" | awk '{print $1}')
    echo "Removing worktree: $worktree_path"
    git worktree remove "$worktree_path" && echo "Worktree removed successfully"
  fi
}

# git worktree remove alias
alias gwr='git-worktree-remove'
source $HOME/.tenv.completion.zsh
