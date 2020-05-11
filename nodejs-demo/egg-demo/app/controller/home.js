'use strict';

const Controller = require('egg').Controller;

class HomeController extends Controller {
    async index() {
        const { ctx } = this;
        ctx.body = await ctx.renderView('index.ejs', { data: 'hello world' });
    }

    async newvide() {
        const { ctx } = this;
        ctx.body = await ctx.renderView('src/new.ejs');
    }

    async dofeng() {
        const { ctx } = this;
        ctx.body = await ctx.renderView('src/dofeng.ejs');
    }
}

module.exports = HomeController;
