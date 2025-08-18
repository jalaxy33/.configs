# profile.ps1 or Microsoft.PowerShell_profile.ps1

function Command-Exist {
    param(
        [string]$name
    )
    Get-Command $name -ErrorAction SilentlyContinue
}


## --- init apps ---

if (Command-Exist zoxide) { Invoke-Expression (& { (zoxide init powershell | Out-String) }) }
# if (Command-Exist uv) {
#     (& uv --generate-shell-completion powershell) | Out-String | Invoke-Expression
#     (& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression
# }

function init_starship {
    Invoke-Expression (&starship init powershell)
}

function init_scoop {
    Invoke-Expression (&scoop-search --hook)
}



## --- alias --- 

# prettier ls
if (Command-Exist eza) {
    function eza-ls { eza -a --icons --git @args }
    Set-Alias -Name ls -Value eza-ls -Option AllScope
}

function ll { ls -l @args }

# smarter cd
if (Command-Exist zoxide) { Set-Alias -Name cd -Value z -Option AllScope }

# yazi
function y {
    $git_dir = Split-Path -Parent (Split-Path -Parent (Get-Command git).Source)
    $env:YAZI_FILE_ONE = "$git_dir\apps\git\current\usr\bin\file.exe"

    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}


## --- set proxy ---

function set_proxy() {
    $proxy_url = "127.0.0.1:7897"
    $http_proxy = "http://$proxy_url"

    $env:HTTP_PROXY = $http_proxy
    $env:HTTPS_PROXY = $http_proxy

    git config --global https.proxy $http_proxy
    git config --global https.proxy $http_proxy

    if (Command-Exist scoop) {
        scoop config proxy $proxy_url
    }
}

function unset_proxy {
    if (Test-Path Env:HTTP_PROXY) {
        Remove-Item Env:HTTP_PROXY
        Remove-Item Env:HTTPS_PROXY
    }

    git config --global --unset http.proxy
    git config --global --unset https.proxy

    if (Command-Exist scoop) {
        scoop config rm proxy
    }
}


## --- environment variables ---

# Rust
$env:RUSTUP_DIST_SERVER = "https://mirrors.ustc.edu.cn/rust-static"
$env:RUSTUP_UPDATE_ROOT = "https://mirrors.ustc.edu.cn/rust-static/rustup"

