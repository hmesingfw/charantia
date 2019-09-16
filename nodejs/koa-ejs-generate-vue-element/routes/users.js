const uuidv1 = require('uuid/v1');
const router = require('koa-router')();
const db = require('../utils/sequelize');
const Sequelize = db.sequelize();
const sysMain = Sequelize.import('../model/sys_main');
const Op = require('sequelize').Op;
router.prefix('/users')


router.get('/', async (ctx, next) => {
    await ctx.render('index')
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
/* 新增修改 */
router.post('/edit', async (ctx, next) => {
    let form = {
        ...ctx.request.body
    }
    let suc = '';
    if (form.id) {
        /* 修改 */
        suc = await sysMain.update(form, { where: { id: form.id } })
    } else {
        /* 新增 */
        form.id = uuidv1();
        suc = await sysMain.create(form);
    }

    ctx.body = {
        code: 200,
        data: suc
    }
})
/* 删除 */
router.post('/delete', async (ctx) => {
    let idArr = ctx.request.body.id;
    let suc = await sysMain.destroy({ where: { 'id': idArr } })
    console.log(suc);
    ctx.body = {
        code: 200,
        data: suc
    }
})

module.exports = router
