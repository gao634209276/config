# Need OWNER=<misid>
: ${OWNER:=`who am i | awk -F' ' '{print $1}'`}
: ${OWNER:=gaoyajun02}
export OWNER

# For spark
alias easy_submit='python /opt/meituan/saron/avocado/spark_submit/easy_submit.py'
export PATH=$SPARK_HOME/bin:$PATH

# For tmux
alias tl='tmux ls'
alias ta='tmux attach-session -t'
alias tn='tmux new-session -s'
alias tk='tmux kill-session -t'
export TMUX_TMPDIR=$HOME/$OWNER/.tmux
if [ -z $TMUX ]; then
    export TERM=xterm-256color
else
    export TERM=screen-256color
fi

# For nvim
# alias nvim='PATH=/opt/meituan/node/bin:/opt/meituan/ctags/bin:$PATH LD_LIBRARY_PATH=/opt/meituan/glibc-2.14/lib /opt/meituan/nvim/bin/nvim'
# unalias nvim
export PATH=/opt/meituan/nvim/bin:/opt/meituan/ctags/bin:/opt/meituan/node/bin:$PATH
export LD_LIBRARY_PATH=/opt/meituan/glibc-2.14/lib/:/usr/local/java/jre/lib/amd64/server:/usr/local/lib
export EDITOR=$HOME/bin/editor
export XDG_CONFIG_HOME=$HOME/$OWNER/.config
export XDG_DATA_HOME=$HOME/$OWNER/.local/share
