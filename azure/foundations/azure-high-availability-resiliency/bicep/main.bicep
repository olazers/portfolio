// Lab 5 - Azure High Availability & Resiliency
// Two zone-separated Ubuntu VMs behind an Azure Standard Public Load Balancer

targetScope = 'resourceGroup'

@description('Azure region used by the HA architecture.')
param location string = resourceGroup().location

@description('Existing virtual network.')
param vnetName string = 'vnet-portfolio-lab'

@description('Dedicated subnet for the highly available web tier.')
param subnetName string = 'snet-ha-web'

@description('Network security group for the HA web tier.')
param nsgName string = 'nsg-ha-web'

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
