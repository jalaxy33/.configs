# ~/.config/fish/config.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    source "$HOME/.cargo/env.fish"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    starship init fish | source
    zoxide init fish | source
    fzf --fish | source

    # aliasing
    alias vi="vim"
    alias hx="helix"
    alias vifish="vim ~/.config/fish/config.fish"
    alias hxfish="hx ~/.config/fish/config.fish"
    alias catfish="cat ~/.config/fish/config.fish"
    alias batfish="bat ~/.config/fish/config.fish"
    alias ls="eza --icons --git -a"
    alias cd="z"

    # homebrew
    set -x HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
    set -x HOMEBREW_CORE_GIT_REMOTE "https://mirrors.ustc.edu.cn/homebrew-core.git"
    set -x HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
    set -x HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"

    # config rust
    set -x RUSTUP_DIST_SERVER "https://mirrors.ustc.edu.cn/rust-static"
    set -x RUSTUP_UPDATE_ROOT "https://mirrors.ustc.edu.cn/rust-static/rustup"

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


function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
