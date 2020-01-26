# pecos
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
