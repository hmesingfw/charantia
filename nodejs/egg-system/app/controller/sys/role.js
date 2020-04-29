'use strict';
const uuidv4 = require('uuid/v4');
const Controller = require('egg').Controller;

class RoleController extends Controller {
    async index() {
        const ctx = this.ctx;
        const query = {
            limit: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page),
            offset: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page - 1),
        };
        ctx.body = await ctx.service.sys.role.list(query);
    }

    async create() {
        const ctx = this.ctx;
        const bodys = ctx.request.body;
        bodys.id = uuidv4();
        const msg = await ctx.service.sys.role.create(bodys);
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

        body.userId = this.ctx.helper.userId();
        const msg = await ctx.service.sys.role.update(id, body);
        ctx.body = {
            msg,
            message: '保存成功',
            code: 200,
        };
    }
    async destroy() {
        const ctx = this.ctx;
        const id = ctx.params.id;

        ctx.body = await ctx.service.sys.role.del(id);
        ctx.status = 200;
    }

    async updateMenus() {
        const ctx = this.ctx;
        const body = ctx.request.body;
        console.log(body);
        const msg = await ctx.service.sys.role.updateRoleMenu(body.roleId, body.menuId);

        ctx.body = {
            msg,
            message: '保存成功',
            code: 200,
        };
        ctx.status = 200;
    }
}

module.exports = RoleController;
