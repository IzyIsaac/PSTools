# AzureAD powershell is being deprecated! Will be using graph in the future

# Connect to azure ad powershell
Install-Module AzureAD
Import-Module AzureAD
Connect-AzureAD

# Find a licenses ServicePlanID's. Useful for dynamic groups or reports
# Get list of owned licenses
Get-AzureADSubscribedSKU
# Use that list to get all the ServicePlanID's
Get-AzureADSubscribedSku -objectid 'SKU ID from previous command ' | SelectObject -expand serviceplans
# A dynamic group filter for users with a specific license. 
# I do the group creation in Azure portal, but could be done with PowerShell
user.assignedPlans -any (assignedPlan.servicePlanId -eq "094e7854-93fc-4d55-b2c0-3ab5369ebdc1" -and assignedPlan.capabilityStatus -eq "Enabled")
