const uuidv1 = require('uuid/v1');
const router = require('koa-router')();
const db = require('../utils/sequelize');
const Sequelize = db.sequelize();
const sysMain = Sequelize.import('../model/sys_main');
const sysBody = Sequelize.import('../model/sys_body')
const Op = require('sequelize').Op;

router.prefix('/tables')


router.get('/', async (ctx, next) => {
    await ctx.render('index', { api: 'tables' })
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
        let bodyId = uuidv1();
        await sysBody.create({ id: bodyId });
        form.id = bodyId;
        form.bodyId = bodyId;
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
    await sysBody.destroy({ where: { 'id': idArr } })
    console.log(suc);
    ctx.body = {
        code: 200,
        data: suc
    }
})


/* 查询数据表 */
router.post('/tableSchema', async (ctx) => {
    const body = await Sequelize.query('SELECT table_name FROM information_schema.tables WHERE table_schema="generate_table"', {
        type: Sequelize.QueryTypes.SELECT
    });
    console.log(body);

    ctx.body = { code: 200, data: body }
})

/* 查询数据表的字段信息 */
router.post('/queryTableFields', async (ctx) => {
    let tableName = ctx.request.body.tableName;
    const body = await Sequelize.query('SHOW FULL COLUMNS FROM ' + tableName, {
        type: 'SELECT'
    });
    ctx.body = { code: 200, data: body }
})

module.exports = router
