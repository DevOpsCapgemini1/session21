param storageAccName string = 'storagefornginx'
param location string = resourceGroup().location
param skuName string = 'Standard_LRS'
param fileShareName string = 'nginxfile'

resource storage_account 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccName
  tags: {
    displayName: storageAccName
  }
  location: location
  kind: 'StorageV2'
  sku: {
    name: skuName
  }
}

resource storage_fileServices 'Microsoft.Storage/storageAccounts/fileServices@2021-09-01' = {
  parent: storage_account
  name: 'default'

  properties: {
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource storage_shares 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-09-01' = {
  parent: storage_fileServices
  name: fileShareName
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }

}
