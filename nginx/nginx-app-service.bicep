param aspName string = 'mbidzins-nginx-asp'
param webAppName string = 'mbidzins-nginx-app'
param location string = resourceGroup().location
param pricingTier string = 'S1'
param numberOfWorkers int = 1
param dockerImage string = 'nginx:latest'

resource aspName_resource 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: aspName
  location: location
  kind: 'linux'
  sku: {
    name: pricingTier
  }
  tags: {
    displayName: aspName
  }
  properties: {
    targetWorkerCount: numberOfWorkers
    reserved: true
  }
}

resource webAppName_resource 'Microsoft.Web/sites@2020-12-01' = {
  name: webAppName
  location: location
  kind: 'app,linux,container'
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/${aspName}': 'Resource'
    displayName: webAppName
  }
  properties: {
    httpsOnly: false
    serverFarmId: aspName_resource.id
    siteConfig: {
      numberOfWorkers: numberOfWorkers
      linuxFxVersion: 'DOCKER|${dockerImage}'
    }
  }
}
