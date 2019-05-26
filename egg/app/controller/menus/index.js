'use strict';

const Controller = require('egg').Controller;


class MenusController extends Controller {
    async getMenus() {
        const {
            ctx,
            service,
        } = this;

        ctx.body = await service.sys.menu.findAll();
    }

    async addMenus() {
        const {
            ctx,
            service
        } = this;
        ctx.body = await service.sys.menu.addMenus();
    }

    async delMenus() {
        const {
            ctx,
            service
        } = this;
        ctx.body = await service.sys.menu.delMenus();
    }

}

module.exports = MenusController;
