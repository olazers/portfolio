// Lab 5 - Network Module
// Existing VNet/subnet references + deployable HA network resources

targetScope = 'resourceGroup'

@description('Azure region.')
param location string = resourceGroup().location

@description('Existing virtual network name.')
param vnetName string

@description('Existing subnet name.')
param subnetName string

@description('HA network security group name.')
param nsgName string

@description('NAT Gateway name.')
param natGatewayName string

@description('NAT Gateway public IP name.')
param natPublicIpName string

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' existing = {
  parent: vnet
  name: subnetName
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-HTTP-Inbound'
        properties: {
          priority: 100
          access: 'Allow'
          direction: 'Inbound'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
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
    tier: 'Regional'
  }
  properties: {
    idleTimeoutInMinutes: 4
    scope: 'Public'
    publicIpAddresses: [
      {
        id: natPublicIp.id
      }
    ]
  }
}
