export OWNER=gaoyajun02
cwd=$(dirname "${BASH_SOURCE-$0}")
cwd=$(cd "${cwd}"; pwd)

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
update_conf $cwd/bashrc $HOME/$OWNER/.bashrc
# update my nvim
for f in "init.vim" "base-settings.vim" "plug-settings.vim" "coc-settings.json" ; do
    update_conf $cwd/nvim/$f $HOME/$OWNER/.config/nvim/$f
done
# update my tmux
mkdir -p $HOME/$OWNER/.tmux
update_conf $cwd/tmux/tmux.conf $HOME/$OWNER/.tmux.conf
update_conf $cwd/tmux/tmuxline.conf $HOME/$OWNER/.tmuxline.conf
update_conf $cwd/tmux/tmux_layout $HOME/$OWNER/.tmux/tmux_layout
