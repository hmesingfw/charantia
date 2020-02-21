'use strict';
const uuidv4 = require('uuid/v4');
const Controller = require('egg').Controller;

class TagController extends Controller {
    async index() {
        const ctx = this.ctx;
        const query = {
            limit: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page),
            offset: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page - 1),
        };
        ctx.body = await ctx.service.sys.tag.list(query);
    }

    async create() {
        const ctx = this.ctx;
        const bodys = ctx.request.body;
        bodys.id = uuidv4();
        const message = await ctx.service.sys.tag.create(bodys);
        ctx.body = {
            message,
            code: 200,
        };
    }

    async update() {
        const ctx = this.ctx;
        const id = ctx.params.id;
        const body = ctx.request.body;
        const message = await ctx.service.sys.tag.update({ id, body });
        ctx.body = {
            message,
            code: 200,
        };
    }
    async destroy() {
        const ctx = this.ctx;
        const id = ctx.params.id;

        ctx.body = await ctx.service.sys.tag.del(id);
        ctx.status = 200;
    }
}

module.exports = TagController;