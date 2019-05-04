'use strict';

const Service = require('egg').Service;

class MenuService extends Service {
    async find() {
        const menu = await this.ctx.model.Sys.Menu.query('select * from user sys_menu');
        return menu;
    }

    async findAll() {
        console.log('12314515');
        const menu = await this.ctx.model.Sys.Menu.query('select * fromsys_menu');
        return menu;
    }
}

module.exports = MenuService;
