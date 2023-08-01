# Create variables
let rNum=$RANDOM*$RANDOM
myLocation=canadacentral
myTopicName="az204-egtopic-${rNum}"
mySiteName="az204-egsite-${rNum}"
mySiteURL="https://${mySiteName}.azurewebsites.net"

# Create a resource group
az group create --name az204-evgrid-rg --location $myLocation

# Register the Event Grid resource provider
az provider register --namespace Microsoft.EventGrid

# Check the registration status
az provider show --namespace Microsoft.EventGrid --query "registrationState"

# Create an Event Grid topic
az eventgrid topic create --name $myTopicName --resource-group az204-evgrid-rg --location $myLocation

# Create a message endpoint
az deployment group create \
    --resource-group az204-evgrid-rg \
    --template-uri "https://raw.githubusercontent.com/Azure-Samples/azure-event-grid-viewer/main/azuredeploy.json" \
    --parameters siteName=$mySiteName hostingPlanName=viewerhost

echo "Your web app URL: ${mySiteURL}"

# Subscribe to the Event Grid topic
endpoint="${mySiteURL}/api/updates"
subId=$(az account show --subscription "" | jq -r '.id')

az eventgrid event-subscription create \
    --source-resource-id "/subscriptions/$subId/resourceGroups/az204-evgrid-rg/providers/Microsoft.EventGrid/topics/$myTopicName" \
    --name az204ViewerSub \
    --endpoint $endpoint

# Retrieve URL and key for the Event Grid topic
topicEndpoint=$(az eventgrid topic show --name $myTopicName -g az204-evgrid-rg --query "endpoint" --output tsv)
key=$(az eventgrid topic key list --name $myTopicName -g az204-evgrid-rg --query "key1" --output tsv)

# Create an event data to send
event='[ {"id": "'"$RANDOM"'", "eventType": "recordInserted", "subject": "myapp/vehicles/motorcycles", "eventTime": "'`date +%Y-%m-%dT%H:%M:%S%z`'", "data":{ "make": "Contoso", "model": "Monster"},"dataVersion": "1.0"} ]'

# Curl the event to the Event Grid topic
curl -X POST -H "aeg-sas-key: $key" -d "$event" $topicEndpoint

# Delete the resource group and all resources within
az group delete --name az204-evgrid-rg --yes --no-wait
```