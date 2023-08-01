# Create variables for the Service Bus namespace and queue names
myLocation=canadacentral
myNameSpaceName=az204svcbus$RANDOM

# Crate a resource group
az group create --name az204-svcbus-rg --location $myLocation

# Create a Service Bus namespace
az servicebus namespace create \
    --resource-group az204-svcbus-rg \
    --name $myNameSpaceName \
    --location $myLocation

# Create a Service Bus queue
az servicebus queue create --resource-group az204-svcbus-rg \
    --namespace-name $myNameSpaceName \
    --name az204-queue

# Remove the resource group
az group delete --name az204-svcbus-rg --yes --no-wait