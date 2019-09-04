var http = require('http');
var conut = 0;
var server = http.createServer(function (req, res) {
    conut++;
    res.write('cishu' + conut);
    res.end();
}).listen(process.env.HTTP1 || 3001)