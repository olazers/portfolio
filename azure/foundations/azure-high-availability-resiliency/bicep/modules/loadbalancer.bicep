// Lab 5 - Load Balancer Module
// Existing Load Balancer resource references

targetScope = 'resourceGroup'

@description('Existing Load Balancer name.')
param loadBalancerName string

@description('Existing frontend IP configuration name.')
param frontendIpConfigName string

@description('Existing backend pool name.')
param backendPoolName string

@description('Existing health probe name.')
param healthProbeName string

@description('Existing load balancing rule name.')
param loadBalancingRuleName string


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
