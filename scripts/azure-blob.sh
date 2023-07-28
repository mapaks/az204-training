# login to azure
az login

# set the default subscription
az account set --subscription $SUBSCRIPTION_ID

# set the default location
az configure --defaults location=$LOCATION

# set the default resource group
az configure --defaults group=$RESOURCE_GROUP

# create a resource group
az group create --name $RESOURCE_GROUP --location $LOCATION
az group create --name az204-blog-rg --location canadacentral

# create a storage account
az storage account create --name $STORAGE_ACCOUNT --location $LOCATION --resource-group $RESOURCE_GROUP --sku Standard_LRS
az storage account create --name nalstorageaccount --location canadacentral --resource-group az204-blog-rg --sku Standard_LRS

# create a container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT
az storage container create --name mycontainer --account-name nalstorageaccount

# delete the resource group
az group delete --name $RESOURCE_GROUP --yes --no-wait
az group delete --name az204-blog-rg --yes --no-wait