'use strict';

const Controller = require('egg').Controller;

class TagController extends Controller {
    async index() {
        const ctx = this.ctx;
        ctx.body = 'hello';
        ctx.status = 200;
    }

}

module.exports = TagController;
