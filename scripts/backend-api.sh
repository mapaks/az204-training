# Create variables for the resource group name and location
myApiName=az204-api-$RANDOM
myLocation=canadacentral
myEmail=nlumapac@gmail.com

# Create a resource group
az group create --name az204-api-rg --location $myLocation

# Create an APIM instance
az apim create --name $myApiName \
    --resource-group az204-api-rg \
    --publisher-email $myEmail \
    --publisher-name AZ204-APIM-Exercise \
    --sku-name Consumption \
    --location $myLocation

# Delete the resource group and all resources within
az group delete --name az204-api-rg --yes --no-wait
```