# env.nu
#
# You can find this config file using:
#   $nu.env-path
#
# Installed by:
# version = "0.106.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
#


# zoxide
zoxide init nushell | save -f ~/.zoxide.nu


# yazi
if $nu.os-info.name == "windows" {
    $env.YAZI_FILE_ONE = which git | get path | get 0 | path dirname | path dirname | path join "apps/git/current/usr/bin/file.exe"
}


# Rust
$env.RUSTUP_DIST_SERVER = "https://mirrors.ustc.edu.cn/rust-static"
$env.RUSTUP_UPDATE_ROOT = "https://mirrors.ustc.edu.cn/rust-static/rustup"

