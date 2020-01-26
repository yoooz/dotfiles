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
alias gcd='cd $(ghq root)/$(ghq list | peco --prompt "REPOSITORY >")'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias gclone='ghq get'
alias gjump='git checkout $(git branch | sed "s/*//g" | sed "s/ //g" | peco --prompt "CHECKOUT BRANCH >")'
alias gdel='git branch -D $(git branch | peco --prompt "DELETE BRANCH >")'
alias psh='ssh `grep "Host " ~/.ssh/config | grep -v "\*" | cut -b 6- | peco --prompt "HOST > "`'

