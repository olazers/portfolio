// Lab 5 - Load Balancer Module
// Deployable public IP and Standard Load Balancer configuration

targetScope = 'resourceGroup'

@description('Azure region.')
param location string = resourceGroup().location

@description('Load Balancer name.')
param loadBalancerName string

@description('Load Balancer public IP name.')
param loadBalancerPublicIpName string

@description('Frontend IP configuration name.')
param frontendIpConfigName string

@description('Backend pool name.')
param backendPoolName string

@description('Health probe name.')
param healthProbeName string

@description('Load balancing rule name.')
param loadBalancingRuleName string


resource loadBalancerPublicIp 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: loadBalancerPublicIpName
  location: location
  zones: [
    '1'
    '2'
    '3'
  ]
  sku: {
    name: 'Standard'
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


resource loadBalancer 'Microsoft.Network/loadBalancers@2024-05-01' = {
  name: loadBalancerName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: frontendIpConfigName
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: loadBalancerPublicIp.id
          }
        }
      }
    ]

    backendAddressPools: [
      {
        name: backendPoolName
      }
    ]

    probes: [
      {
        name: healthProbeName
        properties: {
          protocol: 'Tcp'
          port: 80
          intervalInSeconds: 5
          numberOfProbes: 1
          probeThreshold: 1
        }
      }
    ]

    loadBalancingRules: [
      {
        name: loadBalancingRuleName
        properties: {
          protocol: 'Tcp'
          frontendPort: 80
          backendPort: 80
          enableFloatingIP: false
          idleTimeoutInMinutes: 4
          enableTcpReset: true
          loadDistribution: 'Default'
          disableOutboundSnat: true
          frontendIPConfiguration: {
            id: resourceId(
              'Microsoft.Network/loadBalancers/frontendIPConfigurations'
              loadBalancerName
              frontendIpConfigName
            )
          }
          backendAddressPool: {
            id: resourceId(
              'Microsoft.Network/loadBalancers/backendAddressPools'
              loadBalancerName
              backendPoolName
            )
          }
          probe: {
            id: resourceId(
              'Microsoft.Network/loadBalancers/probes'
              loadBalancerName
              healthProbeName
            )
          }
        }
      }
    ]
  }
}
