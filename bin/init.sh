export OWNER=gaoyajun02
bin=$(dirname "${BASH_SOURCE-$0}")
cwd=$(cd "${bin}/.."; pwd)
source $bin/settings.sh
update_conf() {
    target=$1
    link=$2
    if [ ! -f $target ]; then
        return
    fi
    if [ -f $link ] || [ -L $link ]; then
        /bin/rm $link
    fi
    ln -s $target $link
    echo "ln $target $link"
}
# update my bashrc
cp $HOME/$OWNER/.bashrc $HOME/$OWNER/bashrc_$(date +%Y%m%d_%H%M%S)
cp $cwd/bashrc $HOME/$OWNER/.bashrc
cp $bin/git-completion.bash $HOME/$OWNER/.git-completion.bash
# update vim
update_conf $cwd/vimrc $HOME/$OWNER/.vimrc
# update my nvim
for f in "init.vim" "base-settings.vim" "plug-settings.vim" "coc-settings.json" ; do
    update_conf $cwd/nvim/$f $HOME/$OWNER/.config/nvim/$f
done
# update my tmux
mkdir -p $HOME/$OWNER/.tmux
update_conf $cwd/tmux/tmux.conf $HOME/$OWNER/.tmux.conf
update_conf $cwd/tmux/tmuxline.conf $HOME/$OWNER/.tmuxline.conf
update_conf $cwd/tmux/tmux_layout $HOME/$OWNER/.tmux/tmux_layout

echo "INSTALL_DIR=$INSTALL_DIR \
PATH=$INSTALL_DIR/nvim/bin:$INSTALL_DIR/tools/ctags/bin:/$INSTALL_DIR/node/bin:\$PATH \
LD_LIBRARY_PATH=$INSTALL_DIR/glibc-2.14/lib \
$INSTALL_DIR/nvim/bin/nvim $@" > $HOME/$OWNER/bin/editor
chmod +x $HOME/$OWNER/bin/editor

# custom ssh config path
echo "/usr/bin/ssh -F $HOME/$OWNER/.ssh/config \$@
" > $HOME/$OWNER/bin/ssh
chmod +x $HOME/$OWNER/bin/ssh
# custom git ssh config
echo "ssh -i ~/gaoyajun02/.ssh/git_rsa \$*" > $HOME/$OWNER/bin/gssh
chmod +x $HOME/$OWNER/bin/gssh

echo "
# For tmux
export TMUX_TMPDIR=$HOME/$OWNER/.tmux
# For git
export GIT_SSH=$HOME/$OWNER/bin/gssh
source $HOME/$OWNER/.git-completion.bash

# For nvim
alias nvim='LD_LIBRARY_PATH=$INSTALL_DIR/glibc-2.14/lib $INSTALL_DIR/nvim/bin/nvim'
export INSTALL_DIR=$INSTALL_DIR
export PATH=\$INSTALL_DIR/nvim/bin:\$INSTALL_DIR/ctags/bin:\$INSTALL_DIR/node/bin:\$PATH
export EDITOR=$HOME/$OWNER/bin/editor
export XDG_CONFIG_HOME=$HOME/$OWNER/.config
export XDG_DATA_HOME=$HOME/$OWNER/.local/share

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup=\"\$('$INSTALL_DIR/miniconda2/bin/conda' 'shell.bash' 'hook' 2> /dev/null)\"
if [ \$? -eq 0 ]; then
    eval \"\$__conda_setup\"
else
    if [ -f \"$INSTALL_DIR/miniconda2/etc/profile.d/conda.sh\" ]; then
        . \"$INSTALL_DIR/miniconda2/etc/profile.d/conda.sh\"
    else
        export PATH=\"$INSTALL_DIR/miniconda2/bin:\$PATH\"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda activate python2.7

" >> $HOME/$OWNER/.bashrc
