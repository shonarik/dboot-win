# This script relies on winget. This tool is not always installed.
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
    
    # Create a new process object that starts PowerShell
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    
    # Specify the current script path and name as a parameter
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    
    # Indicate that the process should be elevated
    $newProcess.Verb = "runas";
    
    # Start the new process
    [System.Diagnostics.Process]::Start($newProcess);
    
    # Exit from the current, unelevated, process
    exit
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