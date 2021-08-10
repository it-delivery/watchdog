@minLength(3)
@maxLength(24)
param storageAccountName string
param functionAppName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
  location: resourceGroup().location
}

resource fileServices 'Microsoft.Storage/storageAccounts/fileServices@2021-04-01' = {
  name: '${storageAccountName}/default'
  dependsOn:[
    storageAccount
  ]
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-02-01' = {
  name: '${storageAccountName}/default/${functionAppName}'
  dependsOn: [
    fileServices
  ]
  properties: {
    shareQuota: 2
    accessTier: 'TransactionOptimized'
  }
}


var storageAccountKey = storageAccount.listKeys().keys[0].value
output storageAccountConnectionString string = 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${storageAccountKey};EndpointSuffix=core.windows.net'
