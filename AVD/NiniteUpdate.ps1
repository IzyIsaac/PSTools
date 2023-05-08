# This script should only be run on desktop images, not live session hosts
# Ensure that the ninitepro classic .exe is downloaded to the image somewhere and is set in the variable below

# NinitePro.exe location
$NiniteEXELocation = 'C:\Ninite\NinitePro.exe'

# Create a logfile with the date in the name for auditing updates
$LogFile = Join-Path -Path $NiniteEXELocation.TrimEnd('NinitePro.exe') -ChildPath ('UpdateLog_{0:yyyy-MM-dd}.txt' -f (Get-Date))

# Check if NinitePro.exe exists
if (Test-Path $NiniteEXELocation) {
    # If it does, update installed apps. Wait for ninitepro.exe process to end before continuing
    Write-Host "Updating apps with Ninite..."
    Start-Process -FilePath $NiniteEXELocation -Wait -ArgumentList "/updateonly /silent $LogFile"
    Write-Host "Ninite update completed. Details are available at $logfile"
    Get-Content $LogFile
} else {
    Write-error 'NinitePro.exe not found at $NiniteEXELocation'
}