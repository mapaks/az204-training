# Create some variables
myKeyVault=az204vault-$RANDOM
myLocation=canadacentral

# Create a resource group
az group create --name az204-vault-rg --location $myLocation

# Create a key vault
az keyvault create --name $myKeyVault --resource-group az204-vault-rg --location $myLocation

# Add a secret to the key vault
az keyvault secret set --vault-name $myKeyVault --name "mySecret" --value "myPassword"

# Retrieve a secret from the key vault
az keyvault secret show --name "mySecret" --vault-name $myKeyVault

# Delete the resource group and all resources within
az group delete --name az204-vault-rg --yes --no-wait