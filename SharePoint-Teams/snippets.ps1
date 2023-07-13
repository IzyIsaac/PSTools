# Install SPO Powershell
Install-Module -Name Microsoft.Online.Sharepoint.PowerShell

# Connect to SPO. The URL is the URL you use to access the tenants SharePoint admin center
Connect-SPOService -Url https://mycompany-admin.sharepoint.com

# Disable the "add shortcut to onedrive" button in sharpeoint/teams
# This button when combined with the "Sync" button can cause great chaos. I recommend disabling it on all tenants
Set-SPOTenant -DisableAddShortcutsToOneDrive $true