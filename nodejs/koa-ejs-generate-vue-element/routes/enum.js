const uuidv1 = require('uuid/v1');
const router = require('koa-router')();
const db = require('../utils/sequelize');
const Sequelize = db.sequelize();
const sysEnum = Sequelize.import('../model/sys_enum');
const Op = require('sequelize').Op;

router.prefix('/enum');

router.get('/', async (ctx, next) => {
    await ctx.render('enum', {
        api: 'enum'
    })
})

/* 查询列表 */
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
    let list = await sysEnum.findAll({
        where: form.title ? where : '',
        offset: (form.page - 1) * form.size,
        limit: form.size,
    });
    ctx.body = {
        code: 200,
        data: {
            list: list,
            paging: {
                page: form.page,
                size: form.size,
                totalCount: await sysMain.count({
                    where: where
                })
            }
        },
    }
})
module.exports = router