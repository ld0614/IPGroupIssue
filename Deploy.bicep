
param region string = 'uksouth'

resource UsedIPGroup 'Microsoft.Network/ipGroups@2023-05-01' = {
  name: 'IP-GROUP-01'
  location: region
  properties: {
    ipAddresses: [
      '10.0.0.0/8'
    ]
  }
}

resource NotUsedIPGroup 'Microsoft.Network/ipGroups@2023-05-01' = {
  name: 'IP-GROUP-02'
  location: region
  properties: {
    ipAddresses: [
      '192.168.0.0/16'
    ]
  }
}

resource FW_Policy 'Microsoft.Network/firewallPolicies@2023-05-01' = {
  name: 'FW-Policy'
  location: region
  properties: {
    sku: {
      tier: 'Standard'
    }
  }
}

resource DefaultAllowAll_Collection 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2023-05-01' = {
  parent: FW_Policy
  name: 'Collection'
  properties: {
    priority: 30000
    ruleCollections: [
      {
        name: 'Group'
        priority: 30000
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'
        action: {
          type: 'Allow'
        }
        rules: [
          {
            ruleType: 'NetworkRule'
            name: 'AllowLocalNet'
            ipProtocols: [
              'Any'
            ]
            sourceAddresses: []
            sourceIpGroups: [
              UsedIPGroup.id
            ]
            destinationAddresses: []
            destinationIpGroups: [
              UsedIPGroup.id
            ]
            destinationFqdns: []
            destinationPorts: [
              '*'
            ]
          }
        ]
      }
    ]
  }
}
