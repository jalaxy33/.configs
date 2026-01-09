#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# prompt format
PS1='[\u@\h \W]\$ '


# history related settings
## ignore duplicate lines and space in the history.
HISTCONTROL=ignoredups:ignorespace

## append to the history file, don't overwrite it
shopt -s histappend

## for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50
HISTFILESIZE=100


# color support
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'


# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# startup apps
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(fzf --bash)"


# more aliases
alias vi="vim"
alias hx="helix"
alias ls="eza --icons --git -a"
alias cd="z"
alias rsyncp="rsync -alvhP"

alias vibash="vim ~/.bashrc"
alias hxbash="hx ~/.bashrc"
alias catbash="cat ~/.bashrc"
alias batbash="bat ~/.bashrc"

alias vifish="vim ~/.config/fish/config.fish"
alias hxfish="hx ~/.config/fish/config.fish"
alias catfish="cat ~/.config/fish/config.fish"
alias batfish="bat ~/.config/fish/config.fish"


# config rust
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
#. "$HOME/.cargo/env" 


# config nodejs
export FNM_NODE_DIST_MIRROR="https://npmmirror.com/mirrors/node/"
#eval "$(fnm env --use-on-cd --shell bash)"

# config go
export GOPROXY="https://mirrors.tencent.com/go/"


# proxy functions
function set_proxy() {
    proxy_url="127.0.0.1:7890"
    http_proxy="http://$proxy_url"

    echo "proxy_url: $proxy_url"

    export ALL_PROXY=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy

    git config --global http.proxy $http_proxy
    git config --global https.proxy $http_proxy
}

function unset_proxy() {
    unset ALL_PROXY
    unset HTTP_PROXY
    unset HTTPS_PROXY

    git config --global --unset http.proxy
    git config --global --unset https.proxy
}


# other functions
function y() {
    local tmp
    tmp=$(mktemp -t "yazi-cwd.XXXXXX")
    yazi "$@" --cwd-file="$tmp"
    if read -r -z cwd < "$tmp" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}


