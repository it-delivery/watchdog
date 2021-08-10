@minLength(3)
@maxLength(24)
param storageAccountName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
  location: resourceGroup().location
}

output storageAccountResourceId string = storageAccount.id
