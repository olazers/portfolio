// Lab 5 - Azure High Availability & Resiliency
// Main orchestration file

targetScope = 'resourceGroup'

@description('Azure region.')
param location string = resourceGroup().location


// Network parameters

param vnetName string = 'vnet-portfolio-lab'
param subnetName string = 'snet-ha-web'
param nsgName string = 'nsg-ha-web'
param natGatewayName string = 'natgw-ha-web'
param natPublicIpName string = 'nat-pip-ha-web'


// Load Balancer parameters

param loadBalancerName string = 'lb-ha-web'
param loadBalancerPublicIpName string = 'pip-lb-ha-web'
param frontendIpConfigName string = 'fe-ip-ha-web'
param backendPoolName string = 'be-pool-ha-web'
param healthProbeName string = 'probe-http-ha-web'
param loadBalancingRuleName string = 'rule-http-ha-web'


// Compute parameters

param vm01NicName string = 'vm-ha-web-01840'
param vm02NicName string = 'vm-ha-web-02489'


module network './modules/network.bicep' = {
  name: 'networkModule'
  params: {
    location: location
    vnetName: vnetName
    subnetName: subnetName
    nsgName: nsgName
    natGatewayName: natGatewayName
    natPublicIpName: natPublicIpName
  }
}


module loadbalancer './modules/loadbalancer.bicep' = {
  name: 'loadBalancerModule'
  params: {
    location: location
    loadBalancerName: loadBalancerName
    loadBalancerPublicIpName: loadBalancerPublicIpName
    frontendIpConfigName: frontendIpConfigName
    backendPoolName: backendPoolName
    healthProbeName: healthProbeName
    loadBalancingRuleName: loadBalancingRuleName
  }
}


module compute './modules/compute.bicep' = {
  name: 'computeModule'
  params: {
    location: location
    vm01NicName: vm01NicName
    vm02NicName: vm02NicName
    subnetId: network.outputs.subnetId
    backendPoolId: loadbalancer.outputs.backendPoolId
  }
}
