// Lab 5 - Compute Module
// Existing HA VM and NIC resource references

targetScope = 'resourceGroup'

@description('First HA web VM name.')
param vm01Name string

@description('Second HA web VM name.')
param vm02Name string

@description('First VM network interface name.')
param vm01NicName string

@description('Second VM network interface name.')
param vm02NicName string


resource vm01 'Microsoft.Compute/virtualMachines@2024-07-01' existing = {
  name: vm01Name
}

resource vm02 'Microsoft.Compute/virtualMachines@2024-07-01' existing = {
  name: vm02Name
}

resource vm01Nic 'Microsoft.Network/networkInterfaces@2024-05-01' existing = {
  name: vm01NicName
}

resource vm02Nic 'Microsoft.Network/networkInterfaces@2024-05-01' existing = {
  name: vm02NicName
}
