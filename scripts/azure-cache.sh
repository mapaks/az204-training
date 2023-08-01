# Create a resource group
az group create --name az204-redis-rg --location canadacentral

# Create a Redis cache
redisName=az204redis$RANDOM
az redis create --location canadacentral \
    --resource-group az204-redis-rg \
    --name $redisName \
    --sku Basic --vm-size c0

# Delete the resource group and all resources within
az group delete --name az204-redis-rg --yes --no-wait