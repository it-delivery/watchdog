# Watchdog
Use Microsoft Teams for various notifications through API calls.

# Status
[![Infrastructure-Rollout](https://github.com/it-delivery/watchdog/actions/workflows/infrastructure.yml/badge.svg)](https://github.com/it-delivery/watchdog/actions/workflows/infrastructure.yml)

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