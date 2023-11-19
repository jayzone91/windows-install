Write-Output "Install Scoop"

# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# Invoke-RestMethod get.scoop.sh | Invoke-Expression

Write-Output "Install all Depedencies"
scoop status
scoop bucket add nerd-fonts
scoop bucket add extras
scoop install aria2
scoop config aria2-warning-enabled false
scoop install apps.json

Write-Output "Clone Neovim Config"
# git clone https://github.com/jayzone91/neovim-config $env:USERPROFILE\AppData\Local\nvim

Write-Output "Write Powershell Profile"
$PwShProfilePath = $PROFILE | Split-Path
if (Test-Path -Path $PwShProfilePath -Not) {
    New-Item $PwShProfilePath
}
Move-Item .\Microsoft.PowerShell_profile.ps1 $PwShProfilePath

Write-Output "Copy Oh My Posh Theme"
if (Test-Path $env:USERPROFILE\ohmyposh -Not) {
    New-Item $env:USERPROFILE\ohmyposh
}
Move-Item .\theme.omp.json $env:USERPROFILE\ohmyposh

Write-Output "Open Nvim as Admin"
# ./_nvim.ps1