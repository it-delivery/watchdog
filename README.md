# Watchdog
Use Microsoft Teams for various notifications through API calls.

# Status
[![Infrastructure-Rollout](https://github.com/it-delivery/watchdog/actions/workflows/infrastructure.yml/badge.svg)](https://github.com/it-delivery/watchdog/actions/workflows/infrastructure.yml)
[![Code-Rollout](https://github.com/it-delivery/watchdog/actions/workflows/code.yml/badge.svg)](https://github.com/it-delivery/watchdog/actions/workflows/code.yml)

# Secrets (examples)
## Environment secrets
* AZURE_CREDENTIALS
```json
{
    "clientId": "<GUID>",
    "clientSecret": "<RandomString>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>"
}
```
Note: The SPN must have the `Contributor` RBAC role over the subscription with id mentioned in `subscriptionId` json field.

## Repository secrets
* APPSERVICEPLANNAME = ''
* FUNCTIONAPPNAME = ''
* RESOURCEGROUPLOCATION = 'westeurope'
* RESOURCEGROUPNAME = ''
* STORAGEACCOUNTNAME = ''

# Permissions

Interacting with Teams API via Graph is unsupported for applications, so a real username and password must be placed in the Azure Keyvault and used to further authenticate and obtain the necessary bearer tokens.
Also, the respective user must have the necessary license, too.

However, should the Teams API be open in the future, with the instructions bellow various permissions can be granted to the SPN of the Function App.
This is just an example and must be adapted once Graph API will support app SPN authorization.

```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Import-Module PowerShellGet
Install-Module -Name AzureAD -Confirm:$false
Import-Module AzureAD

Connect-AzureAD -TenantId <your tenant id here>

$MSGraphSPN = Get-AzureADServicePrincipal -Filter "AppId eq '00000003-0000-0000-c000-000000000000'"
$MSGraphSPN.AppRoles | Select-Object Id, Value | Sort-Object Value | Format-Table -AutoSize

$FunctionAppSPN = Get-AzureADServicePrincipal -ObjectId <this is the Managed System Identity of the Function App>
$FunctionAppSPN

# fill bellow based on the App Roles identified for the Graph SPN corresponding to your application needs.
$ApplicationRoles = @(
    'd9c48af6-9ad9-47ad-82c3-63757137b9af' #Chat.Create
    '294ce7c9-31ba-490a-ad7d-97a7d075e4ed' #Chat.ReadWrite.All
)


foreach ($role in $ApplicationRoles) {
    $roleAssignment = @{
        Id = $role
        PrincipalId = $FunctionAppSPN.ObjectId 
        ObjectId = $FunctionAppSPN.ObjectId 
        ResourceId = $MSGraphSPN.ObjectId
    }
    New-AzureADServiceAppRoleAssignment @roleAssignment
}
```