'use strict';


const Controller = require('egg').Controller;


class DemoController extends Controller {

    async datas() {
        const {
            ctx,
            service
        } = this;
        let condition = ctx.request.body;
        ctx.body = await service.sys.demo.datas(condition);

    }


    async save() {
        const {
            ctx,
            service,
        } = this;
        let form = ctx.request.body;

        ctx.body = await service.sys.demo.save(form);
    }

    async delete() {
        const {
            ctx,
            service,
        } = this;
        const id = this.ctx.request.body.id;

        ctx.body = await service.sys.demo.delete(id);
    }
}

module.exports = DemoController;
