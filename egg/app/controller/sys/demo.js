'use strict';


const Controller = require('egg').Controller;


class DemoController extends Controller {
    async getAllDemo() {
        const {
            ctx,
            service,
        } = this;
        let condition = ctx.request.body;
        ctx.body = await service.sys.demo.getAllDemo(condition);
    }
}

module.exports = DemoController;

