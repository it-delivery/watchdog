@minLength(3)
@maxLength(24)
param keyVaultName string

param functionAppIdentity string

resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {
  name: keyVaultName
  location: resourceGroup().location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: functionAppIdentity
        permissions:{
          secrets: [
            'get'
            'list'
          ]
        }
      }
    ]
  }
}
