targetScope = 'subscription'

param rgName string
param location string = deployment().location

// Resource group
resource rgDevContainer 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  location: location
  name: rgName
}
