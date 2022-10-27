# Connecting to Exchange online
Install-Module -Name ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
# Interactive sign-in
Connect-ExchangeOnline -[UserPrincipalName <UPN>] [-DelegatedOrganization <String>]

# Managing mailbox delegation: https://learn.microsoft.com/en-us/powershell/module/exchange/add-mailboxpermission?view=exchange-ps
Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited # View all shared mailboxes
Get-MailboxPermission -Identity john@contoso.com | Format-List # View a mailboxes permissions
Remove-MailboxPermission -Identity <MailboxIdentity> -User <UserIdentity> -AccessRights <FullAccess / SendAs> # Remove a permission
Add-MailboxPermission -Identity <MailboxIdentity> -User <UserIdentity> -AccessRights FullAccess -AutoMapping <$false / $true> # Add a permission

# Dynamic distribution lists
Get-DynamicDistributionGroup # View names of all dynamic lists
Get-DynamicDistributionGroup | fl Freedom,RecipientFilter # View the current filter
Get-Recipient -Filter (Get-DynamicDistributionGroup "A distribution list").RecipientFilter # View what accounts match the current filter
Set-DynamicDistributionGroup -Identity 'A distribution list' -RecipientFilter <Filter> # Set a new recipient filter
    # Some useful filter properties:
    (-not(RecipientTypeDetailsValue -eq 'SharedMailbox')) # Exclude shared mailboxes
    (-not(PrimarySmtpAddress -eq 'someemail@company.org')) # Exclude a specific mailbox