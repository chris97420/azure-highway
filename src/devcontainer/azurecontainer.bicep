param resourcename string = 'aci-universal-devcontainer'

resource devaci 'Microsoft.ContainerInstance/containerGroups@2021-10-01' = {
  name: resourcename
  properties:{
    containers: [
      {
        name: resourcename
        properties: {
          image: 'mcr.microsoft.com/vscode/devcontainers/universal'
          resources: {
            requests: {
              cpu: 8
              memoryInGB: 16
            }
          }
        }
      }
    ]
    osType: 'Linux'
  }
}
