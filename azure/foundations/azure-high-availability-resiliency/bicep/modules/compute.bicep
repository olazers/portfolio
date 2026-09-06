// Lab 5 - Compute Module
// Deployable HA VM network interfaces

targetScope = 'resourceGroup'

@description('Azure region.')
param location string = resourceGroup().location

@description('First VM network interface name.')
param vm01NicName string

@description('Second VM network interface name.')
param vm02NicName string

@description('HA web subnet resource ID.')
param subnetId string

@description('Load Balancer backend pool resource ID.')
param backendPoolId string


resource vm01Nic 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: vm01NicName
  location: location
  properties: {
    enableAcceleratedNetworking: true
    enableIPForwarding: false

    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          primary: true
          privateIPAllocationMethod: 'Dynamic'
          privateIPAddressVersion: 'IPv4'

          subnet: {
            id: subnetId
          }

          loadBalancerBackendAddressPools: [
            {
              id: backendPoolId
            }
          ]
        }
      }
    ]
  }
}


resource vm02Nic 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: vm02NicName
  location: location
  properties: {
    enableAcceleratedNetworking: true
    enableIPForwarding: false

    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          primary: true
          privateIPAllocationMethod: 'Dynamic'
          privateIPAddressVersion: 'IPv4'

          subnet: {
            id: subnetId
          }

          loadBalancerBackendAddressPools: [
            {
              id: backendPoolId
            }
          ]
        }
      }
    ]
  }
}
