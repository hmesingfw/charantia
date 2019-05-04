'use strict';

const Controller = require('egg').Controller;


class MenusController extends Controller {
    async getMenus() {
        const {
            ctx,
            service,
        } = this;
              
        ctx.body = await service.Menu.findAll();

    }
}

module.exports = MenusController;
