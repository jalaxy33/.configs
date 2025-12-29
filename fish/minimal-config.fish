# ~/.config/fish/config.fish

if status is-interactive
    set fish_greeting ""

    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
    fzf --fish | source

    # aliases
    alias vi="vim"
    alias hx="helix"
    alias ls="eza --icons --git -a"
    alias cd="z"

    alias vifish="vim ~/.config/fish/config.fish"
    alias hxfish="hx ~/.config/fish/config.fish"
    alias catfish="cat ~/.config/fish/config.fish"
    alias batfish="bat ~/.config/fish/config.fish"

    alias vibash="vim ~/.bashrc"
    alias hxbash="hx ~/.bashrc"
    alias catbash="cat ~/.bashrc"
    alias batbash="bat ~/.bashrc"

    # config rust
    set -x RUSTUP_DIST_SERVER "https://mirrors.ustc.edu.cn/rust-static"
    set -x RUSTUP_UPDATE_ROOT "https://mirrors.ustc.edu.cn/rust-static/rustup"

    # config nodejs
    set -x FNM_NODE_DIST_MIRROR https://npmmirror.com/mirrors/node/

    # config go
    set -x GOPROXY "https://mirrors.tencent.com/go/"

end

function set_proxy
    set proxy_url "127.0.0.1:7890"
    set http_proxy "http://$proxy_url"

    echo "proxy_url: $proxy_url"

    set -x ALL_PROXY $http_proxy
    set -x HTTP_PROXY $http_proxy
    set -x HTTPS_PROXY $http_proxy

    git config --global http.proxy $http_proxy
    git config --global https.proxy $http_proxy
end

function unset_proxy
    set -u ALL_PROXY
    set -u HTTP_PROXY
    set -u HTTPS_PROXY

    git config --global --unset http.proxy
    git config --global --unset https.proxy
end

