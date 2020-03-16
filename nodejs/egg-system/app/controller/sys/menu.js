'use strict';
const uuidv4 = require('uuid/v4');
const Controller = require('egg').Controller;

class MenuController extends Controller {
    async index() {
        const ctx = this.ctx;
        const where = { ...this.ctx.helper.whereParams, ...ctx.query, parentId: '0' };
        ctx.body = {
            rows: await ctx.service.sys.menu.getTree(where),
        };
    }

    async create() {
        const ctx = this.ctx;
        const bodys = ctx.request.body;
        bodys.id = uuidv4();
        const msg = await ctx.service.sys.menu.create(bodys);
        ctx.body = {
            msg,
            message: '保存成功',
            code: 200,
        };
    }

    async update() {
        const ctx = this.ctx;
        const id = ctx.params.id;
        const body = ctx.request.body;
        const msg = await ctx.service.sys.menu.update(id, body);
        ctx.body = {
            msg,
            message: '保存成功',
            code: 200,
        };
    }
    async destroy() {
        const ctx = this.ctx;
        const id = ctx.params.id;

        ctx.body = await ctx.service.sys.menu.del(id);
        ctx.status = 200;
    }
}

module.exports = MenuController;
