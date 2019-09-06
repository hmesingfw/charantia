const redis = require('redis');

const client = redis.createClient({
    host: 'localhost',
    port: 6379,
    password: '123456'
})

client.set("foo", "hello");
 
// This will return a JavaScript String
client.get("foo", function (err, reply) {
    console.log(reply.toString()); // Will print `OK`
});

client.quit();