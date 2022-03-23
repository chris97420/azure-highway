targetScope = 'subscription'

param rgName string
param location string = deployment().location

// Resource group
resource eirg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  location: location
  name: rgName
}

// Azure Container Instance
module devcontainer 'azurecontainer.bicep' = {
  name: 'aci-universal-devcontainer'
  scope: eirg
  params: {}
}
