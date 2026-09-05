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

@description('NAT Gateway used for explicit outbound connectivity.')
param natGatewayName string = 'natgw-ha-web'

@description('Public IP used by the NAT Gateway.')
param natPublicIpName string = 'nat-pip-ha-web'

@description('Standard Public Load Balancer.')
param loadBalancerName string = 'lb-ha-web'

@description('Load Balancer frontend IP configuration.')
param frontendIpConfigName string = 'fe-ip-ha-web'

@description('Load Balancer backend pool.')
param backendPoolName string = 'be-pool-ha-web'

@description('Load Balancer health probe.')
param healthProbeName string = 'probe-http-ha-web'

@description('Load balancing rule for HTTP traffic.')
param loadBalancingRuleName string = 'rule-http-ha-web'

@description('First zone-separated backend VM.')
param vm01Name string = 'vm-ha-web-01'

@description('Second zone-separated backend VM.')
param vm02Name string = 'vm-ha-web-02'

@description('Network interface attached to vm-ha-web-01.')
param vm01NicName string = 'vm-ha-web-01840'

@description('Network interface attached to vm-ha-web-02.')
param vm02NicName string = 'vm-ha-web-02489'


// Existing network resources

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


// Existing outbound connectivity resources

resource natPublicIp 'Microsoft.Network/publicIPAddresses@2024-05-01' existing = {
  name: natPublicIpName
}

resource natGateway 'Microsoft.Network/natGateways@2024-05-01' existing = {
  name: natGatewayName
}


// Existing Load Balancer resources

resource loadBalancer 'Microsoft.Network/loadBalancers@2024-05-01' existing = {
  name: loadBalancerName
}

resource frontendIpConfig 'Microsoft.Network/loadBalancers/frontendIPConfigurations@2024-05-01' existing = {
  parent: loadBalancer
  name: frontendIpConfigName
}

resource backendPool 'Microsoft.Network/loadBalancers/backendAddressPools@2024-05-01' existing = {
  parent: loadBalancer
  name: backendPoolName
}

resource healthProbe 'Microsoft.Network/loadBalancers/probes@2024-05-01' existing = {
  parent: loadBalancer
  name: healthProbeName
}

resource loadBalancingRule 'Microsoft.Network/loadBalancers/loadBalancingRules@2024-05-01' existing = {
  parent: loadBalancer
  name: loadBalancingRuleName
}


// Existing highly available backend VMs

resource vm01 'Microsoft.Compute/virtualMachines@2024-07-01' existing = {
  name: vm01Name
}

resource vm02 'Microsoft.Compute/virtualMachines@2024-07-01' existing = {
  name: vm02Name
}


// Existing VM network interfaces

resource vm01Nic 'Microsoft.Network/networkInterfaces@2024-05-01' existing = {
  name: vm01NicName
}

resource vm02Nic 'Microsoft.Network/networkInterfaces@2024-05-01' existing = {
  name: vm02NicName
}
