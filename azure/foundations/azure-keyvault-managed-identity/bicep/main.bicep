@description('Azure region for the Key Vault')
param location string = resourceGroup().location

@description('Name of the Key Vault')
param keyVaultName string = 'kv-portfolio-lab-1143'

@description('Existing virtual network name')
param vnetName string = 'vnet-portfolio-lab'

@description('Existing application subnet name')
param subnetName string = 'snet-app'

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' existing = {
  parent: vnet
  name: subnetName
}

resource keyVault 'Microsoft.KeyVault/vaults@2026-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableRbacAuthorization: true
    softDeleteRetentionInDays: 90
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      bypass: 'None'
      defaultAction: 'Deny'
      virtualNetworkRules: [
        {
          id: subnet.id
        }
      ]
    }
  }
}
