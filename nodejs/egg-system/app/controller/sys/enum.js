'use strict';
const uuidv4 = require('uuid/v4');
const Controller = require('egg').Controller;

class EnumController extends Controller {
    async index() {
        const ctx = this.ctx;
        const query = {

            limit: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page),
            offset: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page - 1),
        };
        // ctx.body = await ctx.service.sys.enum.list(query);
        ctx.body = await ctx.service.sys.enum.getTree({ parentId: '0' });
    }

    async create() {
        const ctx = this.ctx;
        const bodys = ctx.request.body;
        bodys.id = uuidv4();
        const message = await ctx.service.sys.enum.create(bodys);
        ctx.body = {
            message,
            msg: '保存成功',
            code: 200,
        };
    }

    async update() {
        const ctx = this.ctx;
        const id = ctx.params.id;
        const body = ctx.request.body;
        const message = await ctx.service.sys.enum.update(id, body);
        ctx.body = {
            message,
            msg: '保存成功',
            code: 200,
        };
    }
    async destroy() {
        const ctx = this.ctx;
        const id = ctx.params.id;

        ctx.body = await ctx.service.sys.enum.del(id);
        ctx.status = 200;
    }
}

module.exports = EnumController;
