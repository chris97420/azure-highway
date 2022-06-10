param ($rgName = 'rg-devcontainer-devsecops-aueast-001', $location = 'australiaeast')

az deployment sub validate --location $location --template-file 'main.bicep' --parameters rgName=$rgName
az deployment sub what-if --location $location --template-file 'main.bicep' --parameters rgName=$rgName
