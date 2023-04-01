# Connecting to Exchange online
Install-Module -Name ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
# Interactive sign-in
Connect-ExchangeOnline -UserPrincipalName $UPN -DelegatedOrganization $orgdomain

# Managing mailbox delegation: https://learn.microsoft.com/en-us/powershell/module/exchange/add-mailboxpermission?view=exchange-ps
Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited # View all shared mailboxes
Get-MailboxPermission -Identity $mailboxidentity | Format-List # View a mailboxes permissions
Remove-MailboxPermission -Identity $mailboxidentity -User $useridentity -AccessRights SendAs # Remove a permission
Add-MailboxPermission -Identity $mailboxidentity -User $useridentity -AccessRights FullAccess -AutoMapping $false # Add a permission

# Dynamic distribution lists
Get-DynamicDistributionGroup # View names of all dynamic lists
Get-DynamicDistributionGroup | format-list Freedom,RecipientFilter # View the current filter
Get-Recipient -Filter (Get-DynamicDistributionGroup "A distribution list").RecipientFilter # View what accounts match the current filter
Set-DynamicDistributionGroup -Identity $distributionidentity -RecipientFilter $filter # Set a new recipient filter
# Some useful filter properties:
$excludeshared = (-not(RecipientTypeDetailsValue -eq 'SharedMailbox')) # Exclude shared mailboxes
$excludemailbox = (-not(PrimarySmtpAddress -eq 'someemail@company.org')) # Exclude a specific mailbox


# All of the below commands enumerate all boxes in the tenant, so they can take
# a while with large tenants
# Getting a list of all mailbox permissions a user has
Get-Mailbox | Get-MailboxPermission -User $useridentity

# Getting a list of all delegate mailbox permissions for all users
get-mailbox | get-mailboxpermission | where-object -Property User -ne "NT AUTHORITY\SELF"