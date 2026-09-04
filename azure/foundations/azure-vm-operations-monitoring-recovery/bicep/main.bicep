@description('Azure region for Lab 4 resources')
param location string = resourceGroup().location

@description('Managed data disk name')
param dataDiskName string = 'vm-app-data01'

@description('NAT Gateway name')
param natGatewayName string = 'natgw-portfolio-app'

@description('Public IP name for the NAT Gateway')
param natPublicIpName string = 'nat-pip'

@description('Existing virtual network name')
param vnetName string = 'vnet-portfolio-lab'

@description('Existing application subnet name')
param subnetName string = 'snet-app'

@description('Existing NSG attached to the application subnet')
param nsgName string = 'nsg-app'

resource dataDisk 'Microsoft.Compute/disks@2024-03-02' = {
  name: dataDiskName
  location: location
  sku: {
    name: 'StandardSSD_LRS'
  }
  properties: {
    diskSizeGB: 32
    diskIOPSReadWrite: 500
    diskMBpsReadWrite: 100
    creationData: {
      createOption: 'Empty'
    }
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    publicNetworkAccess: 'Enabled'
  }
}

resource natPublicIp 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: natPublicIpName
  location: location
  sku: {
    name: 'StandardV2'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    idleTimeoutInMinutes: 4
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource natGateway 'Microsoft.Network/natGateways@2024-05-01' = {
  name: natGatewayName
  location: location
  sku: {
    name: 'StandardV2'
  }
  properties: {
    idleTimeoutInMinutes: 4
    publicIpAddresses: [
      {
        id: natPublicIp.id
      }
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: vnetName
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' existing = {
  name: nsgName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: subnetName
  properties: {
    addressPrefixes: [
      '10.0.2.0/24'
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
    natGateway: {
      id: natGateway.id
    }
    serviceEndpoints: [
      {
        service: 'Microsoft.KeyVault'
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
}