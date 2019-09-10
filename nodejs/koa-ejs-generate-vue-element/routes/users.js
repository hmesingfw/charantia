const router = require('koa-router')();

const db = require('../utils/sequelize');
const Sequelize = db.sequelize();
const sysMain = Sequelize.import('../model/sys_main');

router.prefix('/users')

router.get('/', async (ctx, next) => {
    let list = await sysMain.findAll();
    console.log(list);

    await ctx.render('index', { index: list })
})

router.get('/bar', function (ctx, next) {
    ctx.body = 'this is a users/bar response'
})

module.exports = router
