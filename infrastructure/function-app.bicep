@minLength(3)
@maxLength(24)
param functionAppName string

param appServicePlanResourceId string

@secure()
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
      appSettings:[
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: functionAppName
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: storageAccountConnectionString
        }
        {
          name: 'WEBSITE_QUEUENAME'
          value: functionAppName
        }
        {
          name: 'WEBSITE_WEBDEPLOY_USE_SCM'
          value: 'true'
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
output functionAppIdentity string = functionApp.identity.principalId
