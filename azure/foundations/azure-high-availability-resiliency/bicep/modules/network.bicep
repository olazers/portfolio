// Lab 5 - Network Module
// Existing network foundation references

targetScope = 'resourceGroup'

@description('Existing virtual network name.')
param vnetName string

@description('Existing subnet name.')
param subnetName string

@description('Existing network security group name.')
param nsgName string

@description('Existing NAT Gateway name.')
param natGatewayName string

@description('Existing NAT Gateway public IP name.')
param natPublicIpName string


resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' existing = {
  parent: vnet
  name: subnetName
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' existing = {
  name: nsgName
}

resource natPublicIp 'Microsoft.Network/publicIPAddresses@2024-05-01' existing = {
  name: natPublicIpName
}

resource natGateway 'Microsoft.Network/natGateways@2024-05-01' existing = {
  name: natGatewayName
}
