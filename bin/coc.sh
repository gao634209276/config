bin=$(dirname "${BASH_SOURCE-$0}")
source $bin/settings.sh
if [ ! -d $INSTALL_DIR/node ]; then
    pushd $BUILD_DIR > /dev/null
    # coc nodejs
    if [ ! -f $BUILD_DIR/node.tar.xz ]; then
        wget https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/v10.20.0/node-v10.20.0-linux-x64.tar.xz node.tar.xz
    fi
    mkdir -pv $INSTALL_DIR/node
    tar -xJf node.tar.xz -C $INSTALL_DIR/node --strip-components 1
    # install yarn neovim
    export PATH=$INSTALL_DIR/node/bin:$PATH
    $INSTALL_DIR/node/bin/npm config set registry http://r.npm.sankuai.com
    $INSTALL_DIR/node/bin/npm config set disturl http://npm.sankuai.com/mirrors/node
    $INSTALL_DIR/node/bin/npm install -g cnpm yarn neovim
    popd > /dev/null
fi


# installs
source $bin/conda.sh
# conda install -c conda-forge nodejs yarn tmux -y

if [ ! -d $INSTALL_DIR/miniconda2/envs/python2.7 ]; then
  conda create -p $INSTALL_DIR/miniconda2/envs/python2.7 python=2.7 -y
fi
conda activate python2.7
executable=$(which python)
if [ $executable != "$INSTALL_DIR/miniconda2/envs/python2.7/bin/python" ]; then
  echo "source faild, exit"
  exit 1
fi
# conda update pip
conda install pip=19.3.1 -y
# pip config
# pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip config set global.index-url http://pip.sankuai.com/simple/
pip config set global.trusted-host "pip.sankuai.com pypi.sankuai.com pypi.python.com"
pip config set global.timeout 6000
pip config set install.index-url http://pip.sankuai.com/simple/
pip config set install.trusted-host "pip.sankuai.com pypi.sankuai.com pypi.python.com"
# install
# conda install -c conda-forge -y pathlib2 python-language-server
conda install -c conda-forge -y pylint jedi pynvim ripgrep pygments tmux
# pip install neovim-remote

