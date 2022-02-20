# This script relies on winget. This tool is not always installed.
# You can install winget by opening Windows Store and updating App Installer.

# PowerShell Elevation provided by: https://docs.microsoft.com/en-us/archive/blogs/virtual_pc_guy/a-self-elevating-powershell-script
# Get the ID and security principal of the current user account
 $myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
 $myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
  
 # Get the security principal for the Administrator role
 $adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
  
 # Check to see if we are currently running "as Administrator"
 if ($myWindowsPrincipal.IsInRole($adminRole))
    {
    # We are running "as Administrator" - so change the title and background color to indicate this
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
    $Host.UI.RawUI.BackgroundColor = "DarkBlue"
    clear-host
    }
 else
    {
    # We are not running "as Administrator" - so relaunch as administrator
    Start-Process PowerShell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs

    # Exit from the current, unelevated, process
    Exit
    }
  
 # Run your code that needs to be elevated here

 #################
 ## Begin dboot
 #################

 # PuTTY and Git
 & winget install --id PuTTY.PuTTY --source winget
 & winget install --id Git.Git --source winget
 [System.Environment]::SetEnvironmentVariable('GIT_SSH','C:\Program Files\PuTTY\plink.exe', [System.EnvironmentVariableTarget]::Machine)
 & winget install --id GitHub.GitHubDesktop --source winget

 # .NET 6 & VSCode
 & winget install --id Microsoft.dotnet --source winget
 & winget install --id Microsoft.VisualStudioCode --source winget

 # VisualStudio
 & winget install --exact --id Microsoft.VisualStudio.2022.Community-Preview --source winget

 # Flutter Development
 & winget install --exact --id Google.AndroidStudio --source winget
 & winget install --exact --id Google.Chrome --source winget

 # PowerShell & Terminal
 & winget install --id Microsoft.Powershell --source winget
 & winget install --id Microsoft.WindowsTerminal --source winget

 # WSL2 & Ubuntu
 & wsl --install

 # Docker
 & winget install --id Docker.DockerDesktop --source winget

 Restart-Computer

 #################
 ## End dboot
 #################

 Write-Host -NoNewLine "Press any key to continue..."
 $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
