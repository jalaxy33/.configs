# config.nu
#
# You can find this config file using:
#     $nu.config-path
#
# Installed by:
# version = "0.106.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
#

$env.config.buffer_editor = 'hx'   # code, vi, hx

## --- help functions ---

def command-exist [cmd] {
    which $cmd | length | $in > 0
}

## --- init apps ---

# starship
command-exist starship | if $in {
    mkdir ($nu.data-dir | path join "vendor/autoload")
    starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
}


# zoxide
source ~/.zoxide.nu


## --- alias ---

alias vi = vim

# nushell configs
alias vinu = vi $nu.config-path
alias vinenv = vi $nu.env-path
alias hxnu = hx $nu.config-path
alias hxenv = hx $nu.env-path
alias catnu = cat $nu.config-path
alias catenv = cat $nu.env-path
alias batnu = bat $nu.config-path
alias batenv = bat $nu.env-path

# prettier ls
alias eza = eza -a --icons --git
alias ll = eza -l

# smarter cd
alias cd = z

# yazi
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

## --- set proxy (windows only) ---

def --env set-proxy [proxy_url = "127.0.0.1:7897"] {
    match $nu.os-info.name {
        # only valid for windows
        "windows" => {
            let http_proxy = $"http://($proxy_url)"

            $env.HTTP_PROXY = $http_proxy
            $env.HTTPS_PROXY = $http_proxy

            git config --global http.proxy $http_proxy
            git config --global https.proxy $http_proxy

            command-exist scoop | if $in {
                scoop config proxy $proxy_url
            }
        }
        _ => {
            echo "Proxy settings are not configured for this OS."
        }
    }
}

def --env unset-proxy [] {
    match $nu.os-info.name {
        # only valid for windows
        "windows" => {
            hide-env HTTP_PROXY
            hide-env HTTPS_PROXY

            git config --global --unset http.proxy
            git config --global --unset https.proxy

            command-exist scoop | if $in {
                scoop config rm proxy
            }
        }
        _ => {
            echo "Proxy settings are not configured for this OS."
        }
    }
}
