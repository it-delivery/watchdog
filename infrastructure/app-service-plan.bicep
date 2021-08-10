@minLength(3)
@maxLength(24)
param appServicePlanName string

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name:appServicePlanName
  kind: 'functionapp'
  sku:{
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
  properties:{
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
  location: resourceGroup().location
}

output appServicePlanResourceId string = appServicePlan.id
