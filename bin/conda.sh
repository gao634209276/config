bin=$(dirname "${BASH_SOURCE-$0}")
source $bin/settings.sh
# Note: conda install path is : $INSTALL_DIR/miniconda2
# and ctags/coc depends on conda
if [ ! -d $INSTALL_DIR/miniconda2 ]; then
    if [ ! -f $BUILD_DIR/miniconda2.sh ]; then
        # wget https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh
        wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda2-latest-Linux-x86_64.sh -O $BUILD_DIR/miniconda2.sh
    fi
    sh $BUILD_DIR/miniconda2.sh -b -f -p $INSTALL_DIR/miniconda2
fi
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if [ -f "$INSTALL_DIR/miniconda2/etc/profile.d/conda.sh" ]; then
    . "$INSTALL_DIR/miniconda2/etc/profile.d/conda.sh"
else
    exit 1
fi
# <<< conda initialize <<<
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --add default_channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
conda config --add default_channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
conda config --add default_channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add default_channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes
