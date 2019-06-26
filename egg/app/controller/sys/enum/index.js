'use strict';


const Controller = require('egg').Controller;


class EnumController extends Controller {
    async getAllEnum() {
        const {
            ctx,
            service,
        } = this;
        let condition = ctx.request.body;
        ctx.body = await service.sys.enum.getAllEnum(condition);
    }

    async getEnum() {
        const {
            ctx,
            service,
        } = this;
        let condition = ctx.request.body;
        ctx.body = await service.sys.enum.getEnum(condition);
    }

    async addEnum() {
        const {
            ctx,
            service,
        } = this;
        let form = ctx.request.body;

        ctx.body = await service.sys.enum.addEnum(form);
    }


    async delEnum() {
        const {
            ctx,
            service,
        } = this;
        const id = this.ctx.request.body.id;

        ctx.body = await service.sys.enum.delEnum(id);
    }
}

module.exports = EnumController;
