bin=$(dirname "${BASH_SOURCE-$0}")

if [ -d $INSTALL_DIR/ctags ]; then
    exit 0
fi
source $bin/settings.sh

# need source conda env
source $bin/conda.sh
if [ ! -d $INSTALL_DIR/miniconda2/envs/ctags ]; then
  conda create -p $INSTALL_DIR/miniconda2/envs/ctags python=2.7 -y
fi
conda activate ctags
executable=$(which python)
if [ $executable != "$INSTALL_DIR/miniconda2/envs/ctags/bin/python" ]; then
  echo "source faild, exit"
  exit 1
fi

pushd $BUILD_DIR > /dev/null
# ctags
conda install -c conda-forge autoconf libseccomp -y
conda install -c anaconda automake pkg-config libxml2 -y
# export LD_LIBRARY_PATH=$INSTALL_DIR/gcc-4.8.2/lib:$INSTALL_DIR/miniconda2/envs/python2.7/lib
export LD_LIBRARY_PATH=$INSTALL_DIR/miniconda2/envs/ctags/lib
if [ ! -d $BUILD_DIR/ctags ]; then
    git clone https://github.com.cnpmjs.org/universal-ctags/ctags.git ctags
    # git clone https://github.com/universal-ctags/ctags.git
fi
cd $BUILD_DIR/ctags
./autogen.sh
./configure --prefix=$INSTALL_DIR/ctags
make -j8 > make.log
make install > install.log

popd > /dev/null
