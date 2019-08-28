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

     
    let su = await page.goto("https://www.creditchina.gov.cn/"); 
    await page.waitFor(3000); //等待时间1秒
    console.log(su) 

    // page.goto("https://vip.jd.com");
    await page.waitFor(4000);  
    // await page.click(".ui-dialog-close");
    await page.click(".sign-in");

    // await browser.close();
})();
