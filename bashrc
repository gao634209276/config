# For tmux
alias tl='tmux ls'
alias ta='tmux attach-session -t'
alias tn='tmux new-session -s'
alias tk='tmux kill-session -t'
alias ts='tmux set status'
alias tst='tmux set status-position top'
alias tsb='tmux set status-position bottom'
export TMUX_TMPDIR=$HOME/.tmux
if [ -z $TMUX ]; then
    export TERM=xterm-256color
else
    export TERM=screen-256color
fi
# For Fzf
# export FZF_DEFAULT_OPTS="--layout=reverse --info=inline --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
export BAT_THEME="Solarized (dark)"
export FZF_DEFAULT_OPTS="--layout=reverse --info=inline --preview 'bat --style=numbers --color=always --line-range :500 {} 2> /dev/null'"
# export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --type f"

