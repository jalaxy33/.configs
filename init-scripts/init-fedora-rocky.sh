#!/bin/bash
# init-rocky.sh

# Linux mirror (root required: sudo su - root)
bash <(curl -sSL https://linuxmirrors.cn/main.sh)

# install necessary packages
dnf install git vim curl wget
dnf install gcc-c++

# install fish shell
dnf install fish
echo $(which fish) | tee -a /etc/shells

# set default shell to fish
chsh -s  $(which fish)

# NOTE: if install failed due to RPM-GPG-KEY-EPEL-10
# sudo curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-10 https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-10
# sudo chmod 644 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-10
# sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-10
# sudo dnf clean all
# sudo dnf makecache

# install homebrew
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
/bin/bash -c "$(curl -fsSL https://mirrors.ustc.edu.cn/misc/brew-install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# install softwares with brew
brew install starship zellij eza zoxide fzf 
brew install bat helix 
brew install yazi uv

# install rust
export RUSTUP_DIST_SERVER="https://mirrors.ustc.edu.cn/rust-static"
export RUSTUP_UPDATE_ROOT="https://mirrors.ustc.edu.cn/rust-static/rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# copy config files
cp ~/.bashrc ~/.bashrc.bak
curl -s https://xget.xi-xu.me/gh/jalaxy33/.configs/raw/refs/heads/main/bash/.bashrc -o ~/.bashrc

mkdir -p ~/.config/fish
curl -s https://xget.xi-xu.me/gh/jalaxy33/.configs/raw/refs/heads/main/fish/config.fish -o ~/.config/fish/config.fish

mkdir -p ~/.config
curl -s https://xget.xi-xu.me/gh/jalaxy33/.configs/raw/refs/heads/main/starship/starship.toml -o ~/.config/starship.toml

mkdir -p ~/.config/uv
curl -s https://xget.xi-xu.me/gh/jalaxy33/.configs/raw/refs/heads/main/uv/uv.toml -o ~/.config/uv/uv.toml

mkdir -p ~/.config/pip
curl -s https://xget.xi-xu.me/gh/jalaxy33/.configs/raw/refs/heads/main/pip/pip.conf -o ~/.config/pip/pip.conf


# clean dnf cache and remove unused packages
sudo dnf clean all
sudo dnf autoremove

# limit journal size
sudo journalctl --vacuum-size=50M

# clear specific journal logs
sudo truncate -s 0 /var/log/syslog

# clear homebrew
brew autoremove
brew cleanup --prune all

# remove cache and temp files
rm -rf ~/.cache/*
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# clean rust
cargo install cargo-cache  # install cargo-cache first
cargo cache -age
rm -rf ~/.cargo/registry/*
rm -rf ~/.cargo/git/*
