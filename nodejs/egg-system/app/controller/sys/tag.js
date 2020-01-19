'use strict';

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

}

module.exports = TagController;
