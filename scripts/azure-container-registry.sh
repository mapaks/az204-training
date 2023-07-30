# Create a resource group
az group create --name $ACR_RESOURCE_GROUP --location $ACR_LOCATION
az group create --name az204-acr-rg --location canadacentral

# Create a basic container registry
az acr create --resource-group $ACR_RESOURCE_GROUP --name $ACR_NAME --sku Basic
az acr create --resource-group az204-acr-rg \
    --name nalcontainerregistry --sku Basic

# Create or navigate to a local directory
echo FROM mcr.microsoft.com/hello-world > Dockerfile

# Build a container image and push it to an Azure container registry
az acr build --image "hello-world:v1" --registry $ACR_NAME --file Dockerfile .
az acr build --image sample/hello-world:v1  \
    --registry nalcontainerregistry \
    --file Dockerfile .

# List the repositories in an Azure container registry
az acr repository list --name $ACR_NAME --output table
az acr repository list --name nalcontainerregistry --output table

# List the tags for a repository in an Azure container registry
az acr repository show-tags --name $ACR_NAME --repository hello-world --output table
az acr repository show-tags --name nalcontainerregistry --repository sample/hello-world --output table

# Run a container image from an Azure container registry
az acr run --registry $ACR_NAME --cmd '$Registry/hello-world:v1' --location $ACR_LOCATION
az acr run --registry nalcontainerregistry --cmd '$Registry/sample/hello-world:v1' /dev/null

# Delete the resource group and all resources within
az group delete --name $ACR_RESOURCE_GROUP --yes --no-wait
az group delete --name az204-acr-rg --yes --no-wait
