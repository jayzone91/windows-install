# Install Winget Packages
# PowerShell
winget install 9MZ1SNWT0N5D -h
# Icloud
winget install 9PKTQ5699M62 -h
# Apple Music
winget install 9PFHDD62MXS1 -h

# Install Scoop packages
scoop install main/aria2 main/git

scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts

scoop install versions/neovim-nightly main/ripgrep main/gcc main/make main/python extras/powertoys nerd-fonts/Hack-NF nerd-fonts/Hack-NF-Mono nerd-fonts/Hack-NF-Propo extras/github extras/vcredist2022 extras/terminal-icons main/rust main/nodejs-lts extras/googlechrome

scoop uninstall vcredist2022

# Clone Configs and wallpaper
git clone https://github.com/jayzone91/wallpaper D:/wallpaper
git clone https://github.com/jayzone91/nvim D:/nvim
git clone https://github.com/jayzone91/PowerShell D:/PowerShell
git clone https://github.com/jayzone91/WindowsTerminal D:/WindowsTerminal

# Get Admin
Function Check-RunAsAdministrator()
{
  #Get current user context
  $CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  
  #Check user is running the script is member of Administrator Group
  if($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
  {
       Write-host "Script is running with Administrator privileges!"
  }
  else
    {
       #Create a new Elevated process to Start PowerShell
       $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
 
       # Specify the current script path and name as a parameter
       $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"
 
       #Set the Process to elevated
       $ElevatedProcess.Verb = "runas"
 
       #Start the new elevated process
       [System.Diagnostics.Process]::Start($ElevatedProcess)
 
       #Exit from the current, unelevated, process
       Exit
 
    }
}
 
#Check Script is running with Elevated Privileges
Check-RunAsAdministrator

# Enable Dev Mode
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

# Link Configs
# Link nvim
Start-Process -FilePath "$env:comspec" -ArgumentList "/k", "mklink", "/j","`"$HOME/AppData/Local/nvim`"" , "`"D:\nvim`""

# Link Terminal
rm $HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
Start-Process -FilePath "$env:comspec" -ArgumentList "/k", "mklink", "`"$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json`"" , "`"D:\WindowsTerminal\settings.json`""


# Link Powershell profile
Start-Process -FilePath "$env:comspec" -ArgumentList "/k", "mklink", "/j","`"$HOME/Documents\PowerShell`"" , "`"D:\PowerShell`""
