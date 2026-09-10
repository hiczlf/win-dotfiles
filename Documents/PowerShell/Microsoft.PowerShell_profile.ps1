# proxy
$env:HTTP_PROXY="http://127.0.0.1:7890"
$env:HTTPS_PROXY="http://127.0.0.1:7890"
$env:ALL_PROXY="socks5://127.0.0.1:7890"

# fnm
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression


# must be in the end
Invoke-Expression (& { (zoxide init powershell | Out-String) })