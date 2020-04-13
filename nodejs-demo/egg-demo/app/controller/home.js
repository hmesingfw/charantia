'use strict';

const Controller = require('egg').Controller;

class HomeController extends Controller {
    async index() {
        const { ctx } = this;
        ctx.body = await ctx.renderView('index.ejs', { data: 'hello world' });
    }
}

module.exports = HomeController;
