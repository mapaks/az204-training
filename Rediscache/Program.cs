using StackExchange.Redis;

// connection string to your Redis Cache    
// string connectionString = "REDIS_CONNECTION_STRING";
string connectionString = "az204redis6488.redis.cache.windows.net:6380,password=hxq6EUblat7tfo6PVkpc63GIwW6v2rrjTAzCaAjio4A=,ssl=True,abortConnect=False";

using (var cache = ConnectionMultiplexer.Connect(connectionString))
{
    IDatabase db = cache.GetDatabase();

    // Snippet below executes a PING to test the server connection
    var result = await db.ExecuteAsync("ping");
    Console.WriteLine($"PING = {result.Type} : {result}");

    // Call StringSetAsync on the IDatabase object to set the key "test:key" to the value "100"
    bool setValue = await db.StringSetAsync("test:key", "100");
    Console.WriteLine($"SET: {setValue}");

    // StringGetAsync retrieves the value for the "test" key
    string getValue = await db.StringGetAsync("test:key");
    Console.WriteLine($"GET: {getValue}");
}