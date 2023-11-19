function Prompt {
    $host.UI.RawUI.BackgroundColor = "#191724"
    $host.UI.RawUI.ForegroundColor = "#E0DEF4"
}

& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:USERPROFILE\ohmyposh\theme.omp.json" --print) -join "`n"))
Import-Module -Name Terminal-Icons

# Alias
Set-Alias -Name vim -Value nvim

function .. () {
    Set-Location ..
}
  
function ... () {
    Set-Location ../..
}
  
function .... () {
    Set-Location ../../..
}
  
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function ll () {
    Get-ChildItem -Force
}

function c () {
    Clear-Host
    Get-ChildItem
    Get-Location
}
  