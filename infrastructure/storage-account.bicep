@minLength(3)
@maxLength(24)
param storageAccountName string

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
  location: resourceGroup().location
}
