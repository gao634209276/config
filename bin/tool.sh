TARGET_DIR=/home/sankuai/bin
mkdir -pv $TARGET_DIR
sget() {
    git_hub=https://github.com
    speed_agent=https://ghproxy.com
    wget $speed_agent/$git_hub/$1 -O tmp.tar.gz
    tar -zxf tmp.tar.gz */$2 --strip-components 1 -C $TARGET_DIR
    rm tmp.tar.gz
}
sget sharkdp/fd/releases/download/v8.2.1/fd-v8.2.1-x86_64-unknown-linux-musl.tar.gz $TARGET_DIR/fd
sget sharkdp/bat/releases/download/v0.17.1/bat-v0.17.1-x86_64-unknown-linux-musl.tar.gz $TARGET_DIR/bat
sget BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz $TARGET_DIR/rg
