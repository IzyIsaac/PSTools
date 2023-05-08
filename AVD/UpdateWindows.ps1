# Ensure PSWindowsUpdate is installed on the system.
if(!(Get-installedmodule PSWindowsUpdate)){

    # Ensure NuGet and PowershellGet are installed on system
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module PowershellGet -Force

    # Install latest version of PSWindowsUpdate
    Install-Module PSWindowsUpdate -Force
}
Import-Module PSWindowsUpdate -Force

# Install all available updates. Do not force a reboot
Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot -Verbose 