set -e
# export INSTALL_DIR=/opt/meituan
# export BUILD_DIR=/tmp

# init dir
pushd . >/dev/null
  cd $(dirname $0)
  script_dir=$(pwd)
  root_dir=$(cd "${script_dir}/../"; pwd)
  mkdir -pv ${BUILD_DIR:="$root_dir/build"}
  mkdir -pv ${INSTALL_DIR:="/opt/meituan"}
popd  >/dev/null

