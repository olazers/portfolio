// Lab 5 - Load Balancer Module
// References the existing Standard Load Balancer and backend pool.
// The working Load Balancer configuration was created and validated
// in Azure before being represented in Bicep.

targetScope = 'resourceGroup'

@description('Existing Load Balancer name.')
param loadBalancerName string

@description('Existing backend pool name.')
param backendPoolName string


resource loadBalancer 'Microsoft.Network/loadBalancers@2024-05-01' existing = {
  name: loadBalancerName
}


resource backendPool 'Microsoft.Network/loadBalancers/backendAddressPools@2024-05-01' existing = {
  parent: loadBalancer
  name: backendPoolName
}


output backendPoolId string = backendPool.id
