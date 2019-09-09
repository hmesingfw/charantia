const Koa = require("koa");
const superagent = require("superagent");
var charset = require('superagent-charset');

const cheerio = require("cheerio");
const app = new Koa();
charset(superagent); 

app.use(async (ctx) => {
    superagent.get('http://www.jlbank.com.cn/jlbank/index/cdkll/index.html').end(function (err, sres) {
        if (err) {
            return next(err);
        }
        console.log(sres);
        var $ = cheerio.load(sres.text);


        // $('.topic_title').each(function (idx, element) {
        //     var $element = $(element);
        //     items.push({
        //         title: $element.attr('title'),
        //         url: $element.attr('href')
        //     });
        // })
        // res.send(items);
    })

    ctx.body = 'hello';
})

app.listen(3000);