#!/bin/bash
# init-ubuntu.sh

# solve libunistring
if [ ! -f /lib/x86_64-linux-gnu/libunistring.so.2 ]; then
    echo "libunistring.so.2 not found, creating symlink..."
    ln -s /lib/x86_64-linux-gnu/libunistring.so.5 /lib/x86_64-linux-gnu/libunistring.so.2
fi
apt update

# install necessary packages
apt install curl wget git vim

# Linux mirror
bash <(curl -sSL https://linuxmirrors.cn/main.sh)

# install necessary packages
apt install software-properties-common aptitude
aptitude safe-upgrade

# ssh
aptitude install openssh-server
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
service ssh start

# install fish shell
aptitude install fish
echo $(which fish) | tee -a /etc/shells

# set default shell to fish
chsh -s  $(which fish)

# install softwares with apt
aptitude install eza zoxide 

# install homebrew
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
/bin/bash -c "$(curl -fsSL https://mirrors.ustc.edu.cn/misc/brew-install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# install softwares with brew
brew install starship zellij uv

# copy config files
cp ~/.bashrc ~/.bashrc.bak
curl -s https://xget.xi-xu.me/gh/jalaxy33/.configs/raw/refs/heads/main/bash/minimal.bashrc -o ~/.bashrc

mkdir -p ~/.config/fish
curl -s https://xget.xi-xu.me/gh/jalaxy33/.configs/raw/refs/heads/main/fish/minimal-config.fish -o ~/.config/fish/config.fish

mkdir -p ~/.config
curl -s https://xget.xi-xu.me/gh/jalaxy33/.configs/raw/refs/heads/main/starship/starship.toml -o ~/.config/starship.toml

mkdir -p ~/.config/uv
curl -s https://xget.xi-xu.me/gh/jalaxy33/.configs/raw/refs/heads/main/uv/uv.toml -o ~/.config/uv/uv.toml

mkdir -p ~/.config/pip
curl -s https://xget.xi-xu.me/gh/jalaxy33/.configs/raw/refs/heads/main/pip/pip.conf -o ~/.config/pip/pip.conf


# install softawares with pip
uv tool install nvitop

# create global python environment
uv venv ~/python-venv -p 3.12
ln -sf /root/python-venv/bin/python /bin/python
ln -sf /root/python-venv/bin/python3 /bin/python3

# set VIRTUAL_ENV to avoid uv warning
echo -e '\n# virtual environment\nexport VIRTUAL_ENV=/root/python-venv\nalias pip="uv pip"\nsource /root/python-venv/bin/activate\n' >> ~/.bashrc
echo -e '\n# virtual environment\nset -x VIRTUAL_ENV "/root/python-venv"\nalias pip="uv pip"\nsource /root/python-venv/bin/activate.fish\n' >> ~/.config/fish/config.fish

# install python packages
bash
pip install ipython


# clean up unnecessary files
aptitude clean && aptitude autoclean
brew cleanup --prune all
rm -rf /tmp/*
rm -rf ~/.cache/*

# clean old log files
journalctl --vacuum-time=7d

