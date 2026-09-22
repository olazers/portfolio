// AZ-104 Integration Capstone
//
// This template represents the network configuration validated during the lab.
// The NAT Gateway is referenced as an existing resource because managing the
// live StandardV2 NAT Gateway introduced unsupported-property differences
// during Bicep What-If validation.
//
// Prerequisite:
//   natgw-capstone must already exist in this resource group before deployment.
//
// The live NAT Gateway was deleted after final validation to avoid ongoing
// Azure charges. It must therefore be recreated before redeploying this template.

targetScope = 'resourceGroup'

@description('Azure region used by the AZ-104 capstone resources.')
param location string = resourceGroup().location

// ------------------------------------------------------------
// Existing Shared Networking Resources
// ------------------------------------------------------------

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: 'vnet-az104-capstone'
}

resource natGateway 'Microsoft.Network/natGateways@2024-05-01' existing = {
  name: 'natgw-capstone'
}

// ------------------------------------------------------------
// Network Security Groups
// ------------------------------------------------------------

resource webNsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: 'nsg-capstone-web'
  location: location
  properties: {
    securityRules: [
      {
        name: 'allow-http-internet'
        properties: {
          description: 'Allow HTTP traffic to web tier'
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

resource appNsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: 'nsg-capstone-app'
  location: location
  properties: {
    securityRules: [
      {
        name: 'allow-web-to-app-8080'
        properties: {
          description: 'Allow web subnet to application tier'
          priority: 100
          access: 'Allow'
          direction: 'Inbound'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '8080'
          sourceAddressPrefix: '10.10.1.0/24'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'allow-bastion-ssh'
        properties: {
          priority: 110
          access: 'Allow'
          direction: 'Inbound'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '10.10.3.0/26'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'deny-other-vnet-inbound'
        properties: {
          priority: 200
          access: 'Deny'
          direction: 'Inbound'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

// ------------------------------------------------------------
// Web Subnet
// ------------------------------------------------------------

resource webSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: 'snet-web'
  properties: {
    addressPrefixes: [
      '10.10.1.0/24'
    ]
    defaultOutboundAccess: false
    privateEndpointNetworkPolicies: 'Disabled'
    networkSecurityGroup: {
      id: webNsg.id
    }
    natGateway: {
      id: natGateway.id
    }
  }
}

// ------------------------------------------------------------
// Application Subnet
// ------------------------------------------------------------

resource appSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: 'snet-app'
  properties: {
    addressPrefixes: [
      '10.10.2.0/24'
    ]
    defaultOutboundAccess: false
    privateEndpointNetworkPolicies: 'Disabled'
    networkSecurityGroup: {
      id: appNsg.id
    }
    natGateway: {
      id: natGateway.id
    }
    serviceEndpoints: [
      {
        service: 'Microsoft.KeyVault'
      }
    ]
  }
}

// ------------------------------------------------------------
// Azure Bastion Subnet
// ------------------------------------------------------------

resource bastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: 'AzureBastionSubnet'
  properties: {
    addressPrefixes: [
      '10.10.3.0/26'
    ]
    defaultOutboundAccess: false
    privateEndpointNetworkPolicies: 'Disabled'
  }
}
