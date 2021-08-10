@minLength(3)
@maxLength(24)
param functionAppName string
param appServicePlanResourceId string
param storageAccountConnectionString string

resource functionApp 'Microsoft.Web/sites@2021-01-15' = {
  name: functionAppName
  location: resourceGroup().location
  kind: 'functionapp'
  identity:{
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanResourceId
    reserved: false
    isXenon: false
    hyperV: false
    siteConfig:{
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 0
      powerShellVersion: '~7'
      use32BitWorkerProcess: false
      connectionStrings:[
        {
          name: 'WEBSITE_CONTENTSHARE'
          connectionString: functionAppName
          type: 'Custom'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          connectionString: storageAccountConnectionString
          type: 'Custom'
        }
      ]
    }
    clientAffinityEnabled: false
    hostNamesDisabled: false
    keyVaultReferenceIdentity: 'SystemAssigned'
    httpsOnly: true
    redundancyMode: 'None'
  }
}

output functionAppResourceId string = functionApp.id
