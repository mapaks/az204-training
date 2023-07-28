using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;

Console.WriteLine("Azure Blob Storage exercise\n");

// Run the examples asynchronously, wait for the results before proceeding
ProcessAsync().GetAwaiter().GetResult();

Console.WriteLine("Press enter to exit the sample application.");
Console.ReadLine();

static async Task ProcessAsync()
{
    // Copy the connection string from the portal in the variable below.
    string storageConnectionString = "DefaultEndpointsProtocol=https;AccountName=nalblobstorageaccount;AccountKey=OTFTk4Vk1RUY2ujVB6HHFuIO6wWFPTHJhuf6TVIKlW+rAZ1JUA1m/F9TDN30JppvyD2ElvGlMrM9+AStn/p6bA==;EndpointSuffix=core.windows.net";

    // Create a client that can authenticate with a connection string
    BlobServiceClient blobServiceClient = new BlobServiceClient(storageConnectionString);

    // COPY EXAMPLE CODE BELOW HERE

}