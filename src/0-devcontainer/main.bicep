targetScope = 'subscription'

param rgName string
param location string = deployment().location

// Resource group
resource rgDevContainer 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  location: location
  name: rgName
}

// Azure Container Instance with storage mount
module devcontainer 'devcontainer.bicep' = {
  name: 'aci-universal-devcontainer'
  scope: rgDevContainer
  params: {
    location: location
  }
}
