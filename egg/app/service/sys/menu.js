'use strict';

const Service = require('egg').Service;

class MenuService extends Service {
    async find() {
        const menu = await this.ctx.model.Sys.Menu.query('select * from user sys_menu');
        return menu;
    }

    async findAll() {
        const query = {
            id: 1
        };
        const menu = await this.ctx.model.Sys.Menu.find(query);
        console.log(menu);
        return menu;
    }
}

module.exports = MenuService;

