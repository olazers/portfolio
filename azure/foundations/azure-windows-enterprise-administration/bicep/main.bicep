@description('Existing resource group location.')
param location string = resourceGroup().location

@description('Existing virtual network used by the portfolio labs.')
param vnetName string = 'vnet-portfolio-lab'

@description('Existing Windows subnet.')
param windowsSubnetName string = 'snet-windows'

@description('Existing NSG associated with the Windows subnet.')
param windowsNsgName string = 'nsg-windows'

@description('Existing NAT Gateway providing explicit outbound connectivity.')
param natGatewayName string = 'natgw-windows'

@description('Existing public IP used by the Windows NAT Gateway.')
param natPublicIpName string = 'pip-natgw-windows'

@description('Existing Windows Server VM.')
param windowsVmName string = 'vm-win-admin-01'

@description('Existing managed data disk attached to the Windows Server VM.')
param dataDiskName string = 'vm-win-admin-01-data01'


// ------------------------------------------------------------
// Existing shared network
// ------------------------------------------------------------

resource vnet 'Microsoft.Network/virtualNetworks@2025-05-01' existing = {
  name: vnetName
}

resource windowsSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' existing = {
  parent: vnet
  name: windowsSubnetName
}

resource windowsNsg 'Microsoft.Network/networkSecurityGroups@2025-05-01' existing = {
  name: windowsNsgName
}


// ------------------------------------------------------------
// Existing explicit outbound connectivity
// ------------------------------------------------------------

resource natPublicIp 'Microsoft.Network/publicIPAddresses@2025-05-01' existing = {
  name: natPublicIpName
}

resource natGateway 'Microsoft.Network/natGateways@2025-05-01' existing = {
  name: natGatewayName
}


// ------------------------------------------------------------
// Existing Windows compute resources
// ------------------------------------------------------------

resource windowsVm 'Microsoft.Compute/virtualMachines@2025-04-01' existing = {
  name: windowsVmName
}

resource dataDisk 'Microsoft.Compute/disks@2026-03-02' existing = {
  name: dataDiskName
}


// ------------------------------------------------------------
// Architecture validation outputs
// ------------------------------------------------------------

output labName string = 'Azure Windows & Enterprise Administration'

output region string = location

output virtualNetwork string = vnet.name

output windowsSubnet string = windowsSubnet.name

output windowsSubnetId string = windowsSubnet.id

output networkSecurityGroup string = windowsNsg.name

output natGateway string = natGateway.name

output natPublicIp string = natPublicIp.name

output windowsVm string = windowsVm.name

output windowsVmId string = windowsVm.id

output managedDataDisk string = dataDisk.name

output managedDataDiskId string = dataDisk.id
