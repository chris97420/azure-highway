param resourcename string = 'aci-universal-devcontainer'
param location string = resourceGroup().location

resource devaci 'Microsoft.ContainerInstance/containerGroups@2021-10-01' = {
  name: resourcename
  location: location
  properties: {
    containers: [
      {
        name: resourcename
        properties: {
          image: 'mcr.microsoft.com/vscode/devcontainers/universal'
          resources: {
            requests: {
              cpu: 4
              memoryInGB: 16
            }
          }
        }
      }
    ]
    osType: 'Linux'
  }
}
