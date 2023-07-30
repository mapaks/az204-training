# Create a resource group.
az group create --name $RESOURCE_GROUP --location $LOCATION
az group create --name az204-aci-rg --location canadacentral

DNS_NAME_LABEL=aci-demo-$RANDOM

# Create a container group.
az container create \
  --resource-group $RESOURCE_GROUP \
  --name aci-demo \
  --image microsoft/aci-helloworld \
  --ports 80 \
  --dns-name-label $DNS_NAME_LABEL \
  --location $LOCATION \
  --registry-login-server $ACR_NAME.azurecr.io \
  --registry-username $ACR_USERNAME \
  --registry-password $ACR_PASSWORD

az container create --resource-group az204-aci-rg --name mycontainer --image mcr.microsoft.com/azuredocs/aci-helloworld --ports 80 --dns-name-label $DNS_NAME_LABEL --location canadacentral

  # Show container status.
az container show --resource-group $RESOURCE_GROUP --name aci-demo --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" --out table

az container show --resource-group az204-aci-rg --name mycontainer --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" --out table

# Delete resource group.
az group delete --name $RESOURCE_GROUP --yes --no-wait
az group delete --name az204-aci-rg --yes --no-wait