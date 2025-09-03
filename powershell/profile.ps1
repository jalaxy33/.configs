# profile.ps1 or Microsoft.PowerShell_profile.ps1

## --- Help functions ---

function Command-Exist {
    param(
        [string]$name
    )
    Get-Command $name -ErrorAction SilentlyContinue
}


## --- shell behaviors ---

# make tab completion using /
# Reference: 
#  - https://www.bilibili.com/video/BV1B2421K7Qo/
#  - https://github.com/PowerShell/PSReadLine/issues/3205
# PSReadLine is required： https://github.com/PowerShell/PSReadLine
Set-PSReadLineKeyHandler -Chord Tab -ScriptBlock {
  $content = ""
  $index = 0

  [Microsoft.PowerShell.PSConsoleReadLine]::ViTabCompleteNext()
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref] $content, [ref] $index)
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($content.Replace('\','/'))
  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($index)
}


## --- init apps ---

if (Command-Exist zoxide) { Invoke-Expression (& { (zoxide init powershell | Out-String) }) }

function init-starship {
    Invoke-Expression (&starship init powershell)
}
if (Command-Exist starship) { init-starship }

function init-scoop {
    Invoke-Expression (&scoop-search --hook)
}
if (Command-Exist scoop-search) { init-scoop }


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
    $file_cmd_path = "$git_dir\apps\git\current\usr\bin\file.exe"
    if (Test-Path $file_cmd_path) {
        $env:YAZI_FILE_ONE = $file_cmd_path
    }

    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}
