const Koa = require("koa");
const superagent = require("superagent");
var charset = require('superagent-charset');

const cheerio = require("cheerio");
const app = new Koa();
charset(superagent);

app.use(async (ctx) => {
    let name = '湖南普亿特';
    superagent.get(`https://www.creditchina.gov.cn/xinyongfuwu/tongyishehuixinyongdaimachaxunzhuanlan/shehuixinyongdaimachaxun/index.html?keyword=${name}`).end(function (err, sres) {
        if (err) {
            return next(err);
        }
        var $ = cheerio.load(sres.text);
        // let content = $('#societyCodeCheck table tbody').html();
        console.log($);
    })

    ctx.body = 'hello';
})

app.listen(3000);