# glibc
bin=$(dirname "${BASH_SOURCE-$0}")
source $bin/settings.sh
# check
if [ -d $INSTALL_DIR/glibc-2.14 ]; then
    exit 0
fi

pushd $BUILD_DIR > /dev/null
# wget http://ftp.gnu.org/gnu/glibc/glibc-2.14.tar.gz
# tar -xf glibc-2.14.tar.gz
export LD_LIBRARY_PATH=/usr/local/java/jre/lib/amd64/server:/usr/local/lib
if [ ! -d $BUILD_DIR/glibc-2.14 ]; then
    git clone https://mirrors.tuna.tsinghua.edu.cn/git/glibc.git glibc-2.14
fi
mkdir -p $BUILD_DIR/glibc-2.14/build
cd $BUILD_DIR/glibc-2.14/build
git checkout glibc-2.14
# build
../configure --prefix=$INSTALL_DIR/glibc-2.14 --disable-profile --enable-add-ons
make -j10 > make.log
make install > install.log
cp /etc/ld.so.conf $INSTALL_DIR/glibc-2.14/etc/
make install > install2.log
# build localtime
make localedata/install-locales
cd $INSTALL_DIR/glibc-2.14/etc
rm localtime && ln -s ../share/zoneinfo/Asia/Shanghai localtime

popd > /dev/null

