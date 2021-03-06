const Koa = require("koa");
const router = require('koa-router')();
const puppeteer = require("puppeteer");
const cheerio = require("cheerio");

const app = new Koa();

router.get('/:name', async (ctx) => {
    let name = ctx.params.name;
    let returnstr = await getvalue(name);
    console.log(returnstr);
    var $ = cheerio.load(returnstr);
    let s = {
        name: $('p').text(),
        code: $('table td').eq(1).text(),
        codes: returnstr.substring(returnstr.indexOf('</td><td>') + 9, returnstr.indexOf('</td><td>')),
    }
    console.log(s)
    ctx.body = s;
})
async function getvalue(companyName = '') {
    console.log(companyName);
    const browser = await puppeteer.launch({
        width: 1600,
        height: 1000,

        // 若是手动下载的chromium需要指定chromium地址, 默认引用地址为 /项目目录/node_modules/puppeteer/.local-chromium/
        // executablePath: "E:/Program Files/chrome-win32/chrome.exe",
        //设置超时时间
        timeout: 15000,
        //如果是访问https页面 此属性会忽略https错误
        ignoreHTTPSErrors: true,
        // 打开开发者工具, 当此值为true时, headless总为false
        devtools: false,
        // 关闭headless模式, 不会打开浏览器   false 为打开浏览器
        headless: false
    });
    const page = await browser.newPage();

    await page.goto("https://www.creditchina.gov.cn/xinyongfuwu/tongyishehuixinyongdaimachaxunzhuanlan/shehuixinyongdaimachaxun/index.html");
    await page.waitFor(1500); //等待时间1秒
    await page.type('.scs-input-group input', companyName, { delay: 200 });            // 输入
    await page.click('.scs-input-group a');                                             // 点击
    await page.waitFor(1500);
    return await page.$eval('#societyCodeCheck table tbody', el => el.outerHTML);             // 获取页面内容
    // await page.waitFor(4000);
    // await browser.close();               //  关闭浏览器
}
app.use(router.routes());   /*启动路由*/
app.use(router.allowedMethods());
app.listen(3000);