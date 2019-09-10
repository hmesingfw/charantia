const puppeteer = require("puppeteer");
const cheerio = require("cheerio");

(async () => {
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
        headless: true
    });
    const page = await browser.newPage();

    await page.goto("https://www.creditchina.gov.cn/xinyongfuwu/tongyishehuixinyongdaimachaxunzhuanlan/shehuixinyongdaimachaxun/index.html");
    await page.waitFor(1000); //等待时间1秒
    await page.type('.scs-input-group input', '湖南普亿特', { delay: 200 });            // 输入
    await page.click('.scs-input-group a');                                             // 点击
    await page.waitFor(500);
    // societyCodeCheck
    let content = await page.$eval('#societyCodeCheck table tbody', el => el.outerHTML);             // 获取页面内容

    console.log(content);
    await page.waitFor(4000);

    // await browser.close();               //  关闭浏览器
})();
