'use strict';

const Controller = require('egg').Controller;

class GenerateController extends Controller {
    async index() {
        const {
            ctx,
            logger
        } = this;

        logger.info('hello');
        const data = {
            list: 'egg'
        };

        // render a template, path relate to `app/view`
        // await ctx.render('/generate/single/index.ejs', data);
        ctx.body = await ctx.renderView('/generate/single/index.ejs', data);
    }
}

module.exports = GenerateController;
