const router = require('koa-router')();
const fs = require('fs');
const ejs = require('ejs');
const path = require('path');

router.get('/', async (ctx, next) => {
    await ctx.render('index', {
        title: 'Hello Koa 22!'
    })
})

router.get('/string', async (ctx, next) => {
    console.log(process.cwd(), '是当前执行node命令时候的文件夹地址 工作地址 绝对路径');
    let file = fs.readFileSync(path.join(process.cwd(), '/views/create.ejs'), 'utf8')

    let efile = ejs.render(file, { list: 'hello world' })
    console.log(efile);

    fs.writeFileSync(path.join(process.cwd(), '/views/create.html'), efile)
    ctx.body = 'koa2 string'
})

router.get('/json', async (ctx, next) => {
    ctx.body = {
        title: 'koa2 json'
    }
})

module.exports = router
