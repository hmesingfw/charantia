'use strict';
const uuidv4 = require('uuid/v4');
const Controller = require('egg').Controller;

class UserController extends Controller {
    async index() {
        const ctx = this.ctx;
        const query = {
            limit: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page),
            offset: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page - 1),
        };
        ctx.body = await ctx.service.sys.user.list(query);
    }

    async create() {
        const ctx = this.ctx;
        const bodys = ctx.request.body;
        bodys.id = uuidv4();
        const msg = await ctx.service.sys.user.create(bodys);
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
        const msg = await ctx.service.sys.user.update(id, body);
        ctx.body = {
            msg,
            message: '保存成功',
            code: 200,
        };
    }
    async destroy() {
        const ctx = this.ctx;
        const id = ctx.params.id;

        ctx.body = await ctx.service.sys.user.del(id);
        ctx.status = 200;
    }


    async login() {
        const ctx = this.ctx;
        const body = ctx.request.body.params;
        const query = {
            where: { phone: body.username },
        };
        const list = await ctx.service.sys.user.find(query);
        if (list.length > 0) {
            const userInfo = list[0];

            if (userInfo.password != body.password) { //eslint-disable-line
                ctx.body = { code: 4001, message: '账号密码输入错误，请重新输入' };
            } else if (userInfo.status === 1 || userInfo.is_del === 1) {
                ctx.body = { code: 4001, message: '账号已停用，请联系管理人员' };
            } else {
                ctx.body = {
                    code: 200,
                    token: '77777777777777777777',
                    message: '',
                };
            }
        } else {
            ctx.body = { code: 4001, message: '账号密码输入错误，请重新输入' };
        }

        ctx.status = 200;
    }
}

module.exports = UserController;
