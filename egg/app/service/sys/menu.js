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
        const menu = await this.ctx.model.Sys.Menu.findAll();
        let reArr = [];
        reArr = sysutils.getTree(menu, 0);
        return reArr;
    }

    async addMenus() {
        const form = this.ctx.request.body;
        const body = await this.ctx.model.Sys.Menu.create({
            id: sysutils.UUID(),
            ...form
        });
        return body;
    }
}

module.exports = MenuService;
