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
        group: {
            [Op.eq]: form.group,
        }
    }
    let list = await sysEnum.findAll({
        where: form.group ? where : '',
        offset: (form.page - 1) * form.size,
        limit: form.size,
        order: [
            ['group', 'DESC'],
        ],
    });
    ctx.body = {
        code: 200,
        data: {
            list: list,
            paging: {
                page: form.page,
                size: form.size,
                totalCount: await sysEnum.count({
                    where: form.group ? where : '',
                })
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
        suc = await sysEnum.update(form, {
            where: {
                id: form.id
            }
        })
    } else {
        /* 新增 */
        form.id = uuidv1();
        suc = await sysEnum.create(form);
    }

    ctx.body = {
        code: 200,
        data: suc
    }
})

/* 删除 */
router.post('/delete', async (ctx) => {
    let idArr = ctx.request.body.id;
    let suc = await sysEnum.destroy({
        where: {
            'id': idArr
        }
    })
    ctx.body = {
        code: 200,
        data: suc
    }
})

/* 查询所属组的值 */
router.post('/queryGroup', async (ctx) => {
    const body = await Sequelize.query('SELECT `group` from sys_enum GROUP BY `group`', {
        type: Sequelize.QueryTypes.SELECT
    });
    console.log(body);

    ctx.body = {
        code: 200,
        data: body
    }
})
module.exports = router