# nvim
bin=$(dirname "${BASH_SOURCE-$0}")
source $bin/settings.sh
if [ -d $INSTALL_DIR/nvim ];then
    exit 0
fi

pushd $BUILD_DIR > /dev/null
if [ ! -f $BUILD_DIR/nvim.tar.gz ]; then
    # wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz
    speed_agent=https://github.91chifun.workers.dev/
    speed_agent=https://ghproxy.com
    wget $speed_agent/https://github.com/neovim/neovim/releases/download/v0.4.4/nvim-linux64.tar.gz -O nvim.tar.gz
fi
mkdir -pv $INSTALL_DIR/nvim
tar -xf nvim.tar.gz -C $INSTALL_DIR/nvim --strip-components 1
popd > /dev/null

