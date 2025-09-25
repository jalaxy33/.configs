# ~/.config/fish/config.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    starship init fish | source
    zoxide init fish | source

    # aliasing
    alias vi="vim"
    alias vifish="vim ~/.config/fish/config.fish"
    alias catfish="cat ~/.config/fish/config.fish"
    alias ls="eza --icons --git -a"
    alias cd="z"

    # homebrew
    set -x HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
    set -x HOMEBREW_CORE_GIT_REMOTE "https://mirrors.ustc.edu.cn/homebrew-core.git"
    set -x HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
    set -x HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"

end
