# Install the Azure Container Apps extension for VS Code.
az extension add --name containerapp --upgrade

# Register the Microsoft.App namespace
az provider register --namespace Microsoft.App

# Register the Microsoft.OperationalInsights namespace
az provider register --namespace Microsoft.OperationalInsights

# Set environment variables
myRG=az204-appcont-rg
myLocation=canadacentral
myAppContEvn=az204-env-$RANDOM

# Create a resource group
az group create \
    --name $myRG \
    --location $myLocation

# Create an environment
az containerapp env create \
    --name $myAppContEvn \
    --resource-group $myRG \
    --location $myLocation

# Create a container app
az containerapp create \
    --name my-container-app \
    --resource-group $myRG \
    --environment $myAppContEvn \
    --image mcr.microsoft.com/azuredocs/containerapps-helloworld:latest \
    --target-port 80 \
    --ingress 'external' \
    --query properties.configuration.ingress.fqdn 

# Delete resource group
az group delete \
    --name $myRG \
    --yes \
    --no-wait