# Connect to azure ad powershell
Install-Module AzureAD
Import-Module AzureAD
Connect-AzureAD

# Get list of owned licenses
Get-AzureADSubscribedSKU
# Use that list to get ServicePlanID for scripting use
Get-AzureADSubscribedSku -objectid <License Object ID> | select -expand serviceplans

user.assignedPlans -any (assignedPlan.servicePlanId -eq "094e7854-93fc-4d55-b2c0-3ab5369ebdc1" -and assignedPlan.capabilityStatus -eq "Enabled")
