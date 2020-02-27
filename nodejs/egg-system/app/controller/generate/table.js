'use strict';
const uuidv4 = require('uuid/v4');
const Controller = require('egg').Controller;

class TableController extends Controller {
    async index() {
        const ctx = this.ctx;
        const query = {
            limit: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page),
            offset: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page - 1),
        };
        const list = await ctx.service.generate.table.list(query);
        ctx.body = list;
    }

    async create() {
        const ctx = this.ctx;
        const body = ctx.request.body;
        body.id = uuidv4();
        const message = await ctx.service.generate.table.create(body);
        ctx.body = {
            message,
            code: 200,
        };
    }

    async show() {
        const ctx = this.ctx;
        const id = ctx.params.id;
        const info = await ctx.service.generate.table.show(id);
        ctx.body = {
            data: info,
            code: 200,
        };
    }

    async update() {
        const ctx = this.ctx;
        const id = ctx.params.id;
        const body = ctx.request.body;
        const message = await ctx.service.generate.table.update(id, body);
        ctx.body = {
            message,
            code: 200,
        };
    }

    async destroy() {
        const ctx = this.ctx;
        const id = ctx.params.id;

        ctx.body = await ctx.service.generate.table.del(id);
        ctx.status = 200;
    }
}

module.exports = TableController;
