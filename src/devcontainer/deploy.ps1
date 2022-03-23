param ($deploymentName = 'devcontainer', $rgName = 'rg-devcontainer-devsecops-aueast-001', $location = 'australiaeast')

az deployment sub create --location $location --template-file 'main.bicep' --parameters rgName=$rgName --name $deploymentName
