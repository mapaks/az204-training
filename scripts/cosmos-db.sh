# Sign in to Azure
az login

# Create a resource group
az group create --name az204-cosmos-rg --location canadacentral

# Create a Cosmos DB account
az cosmosdb create --name az204-nal-cosmosdb --resource-group az204-cosmos-rg

# Retrieve the primary key
az cosmosdb keys list --name az204-nal-cosmosdb --resource-group az204-cosmos-rg

# Delete the resource group
az group delete --name az204-cosmos-rg --yes --no-wait