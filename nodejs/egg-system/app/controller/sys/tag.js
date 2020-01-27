'use strict';
const uuidv4 = require('uuid/v4');
const Controller = require('egg').Controller;

class TagController extends Controller {
    async index() {
        const ctx = this.ctx;
        const query = {
            limit: ctx.helper.parseInt(ctx.query.limit),
            offset: ctx.helper.parseInt(ctx.query.offset),
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
        const tag = await ctx.model.Sys.Tag.findByPk(id);
        const body = ctx.request.body;
        const message = await tag.update(body);
        ctx.body = {
            message,
            code: 200,
        };
    }
}

module.exports = TagController;
