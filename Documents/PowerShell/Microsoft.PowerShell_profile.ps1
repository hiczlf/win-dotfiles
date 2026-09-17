# proxy
$env:HTTP_PROXY="http://127.0.0.1:7890"
$env:HTTPS_PROXY="http://127.0.0.1:7890"
$env:ALL_PROXY="socks5://127.0.0.1:7890"

# set Emacs key bindings for the command line
Set-PSReadLineOption -EditMode Emacs


# fnm
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression


# personal scripts
$personalBin = Join-Path $HOME '.local\bin'
if (($env:PATH -split ';') -notcontains $personalBin) {
    $env:PATH = "$personalBin;$env:PATH"
}

# must be in the end
Invoke-Expression (& { (zoxide init powershell | Out-String) })
