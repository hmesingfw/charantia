const router = require('koa-router')();

const db = require('../utils/sequelize');
const Sequelize = db.sequelize();
const sysMain = Sequelize.import('../model/sys_main');
const Op = require('sequelize').Op;
router.prefix('/users')

router.get('/', async (ctx, next) => {
    await ctx.render('index')
})

router.post('/list', async (ctx, next) => {
    let form = {
        ...ctx.request.body
    }
    // 查询条件
    let where = {
        title: {
            [Op.like]: `%${form.title || ''}%`
        }
    }
    let list = await sysMain.findAll({
        where: form.title ? where : '',
        offset: (form.page - 1) * form.size,
        limit: form.size,
        order: [
            ['updatedAt', 'DESC'],
        ],
    });
    ctx.body = {
        code: 200,
        data: {
            list: list,
            paging: {
                page: form.page,
                size: form.size,
                totalCount: await sysMain.count({ where: where })
            }
        },
    }

})

router.get('/bar', function (ctx, next) {
    ctx.body = 'this is a users/bar response'
})

module.exports = router
