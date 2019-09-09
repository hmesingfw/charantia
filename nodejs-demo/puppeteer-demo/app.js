const puppeteer = require("puppeteer");

(async () => {
    const browser = await puppeteer.launch({
        width: 1600,
        height: 1000,

        // 若是手动下载的chromium需要指定chromium地址, 默认引用地址为 /项目目录/node_modules/puppeteer/.local-chromium/
        executablePath: "E:/Program Files/chrome-win32/chrome.exe",
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


    await page.goto("http://www.jlbank.com.cn");
    await page.waitFor(3000); //等待时间1秒
    let s = await page.click('.tempWrap .bjfwlist2 span:nth-child(4)');
    console.log(s);
    // await page.type('#search_input', '湖南普亿特', { delay: 200 })
    // let su = await page.click('.search .search_btn');
    // console.log(su)

    // page.goto("https://vip.jd.com");
    await page.waitFor(4000);

    // await browser.close();
})();
