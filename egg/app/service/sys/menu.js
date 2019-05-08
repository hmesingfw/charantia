'use strict';

const Service = require('egg').Service;

const SysUtils = require('../../utils/sys');
const sysutils = new SysUtils();
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
        return menu;
    }

    async addMenus() {
        const body = await this.ctx.model.Sys.Menu.create({
            id: sysutils.UUID(),
            title: '第一个插入'
        });
        return body;
    }
}

module.exports = MenuService;
