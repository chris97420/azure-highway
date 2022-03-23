param resourcename string = 'aci-universal-devcontainer'
param location string = resourceGroup().location

// Storage account for the development container
resource devStorageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  kind: 'StorageV2'
  location: location
  name: 'stdevcontainer'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

// File share to be mounted on the development container
resource devFileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-04-01' = {
  name: '${devStorageAccount.name}/default/devcontainer-volume'
}

// Azure Container Instance
resource devaci 'Microsoft.ContainerInstance/containerGroups@2021-10-01' = {
  name: resourcename
  location: location
  properties: {
    containers: [
      {
        name: resourcename
        properties: {
          image: 'mcr.microsoft.com/vscode/devcontainers/universal'
          ports: [
            {
              port: 22
              protocol: 'TCP'
            }
          ]
          resources: {
            requests: {
              cpu: 4
              memoryInGB: 16
            }
          }
          volumeMounts: [
            {
              name: 'devcontainervolume'
              mountPath: '/home/workspace'
            }
          ]
        }
      }
    ]
    osType: 'Linux'
    restartPolicy: 'Always'
    ipAddress: {
      type: 'Public'
      ports: [
        {
          port: 22
          protocol: 'TCP'
        }
      ]
    }
    volumes: [
      {
        name: 'devcontainervolume'
        azureFile: {
          shareName: 'devcontainer-volume'
          storageAccountName: devStorageAccount.name
          storageAccountKey: devStorageAccount.listKeys().keys[0].value
        }
      }
    ]
  }
}

output devContainerIPv4Address string = devaci.properties.ipAddress.ip
