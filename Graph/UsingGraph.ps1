# Installing graph
Install-Module Microsoft.Graph

<# Connecting to Graph
Scopes need to be selected before using an API endpoint that requires that scope. 
You can use Connect-MgGraph multiple times in your session to add more scopes as you go
#>
Connect-MgGraph -Scopes ['User.Read.All', 'Group.Read.All']

# Printing all possible graph permission scopes:
Find-MgGraphPermission

# Get permission for a specific endpoint or command
# This can also be used to find the command associated with an endpoint or vice versa
Find-MgGraphCommand -Uri /users
Find-MgGraphPermssion -Command Get-MgUser
