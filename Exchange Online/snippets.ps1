# Connecting to Exchange online
Install-Module -Name ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
# Interactive sign-in
Connect-ExchangeOnline -[UserPrincipalName <UPN>] [-DelegatedOrganization <String>]
