# !/bin/bash
bin=$(dirname "${BASH_SOURCE-$0}")
source $bin/settings.sh
sh $bin/nvim.sh
sh $bin/glibc.sh
# LD_LIBRARY_PATH=$INSTALL_DIR/glibc-2.14:/usr/local/java/jre/lib/amd64/server:/usr/local/lib
# if use ctags, tmux, coc use conda install
sh $bin/conda.sh
sh $bin/ctags.sh
# e.g. coc/tmux/python-coc
sh $bin/coc.sh
sh $bin/tool.sh











