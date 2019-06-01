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

        const menu = await this.ctx.model.Sys.Menu.findAll({
            order: [
                [ 'sort', 'DESC' ]
            ],
        });
        let reArr = [];
        reArr = sysutils.getTree(menu, 0);
        return reArr;
    }

    async addMenus() {
        const form = this.ctx.request.body;
        let body;
        if (form.id) {
            body = await this.ctx.model.Sys.Menu.update({
                ...form
            }, {
                where: {
                    id: form.id
                }
            });
            if (body.length > 1) {
                body = '1';
            }
        } else {
            body = await this.ctx.model.Sys.Menu.create({
                id: sysutils.UUID(),
                ...form
            });
            if (body) {
                body = '1';
            }
        }
        return body;
    }

    async delMenus() {
        const id = this.ctx.request.body.id;
        const body = await this.ctx.model.Sys.Menu.destroy({
            where: {
                id
            }
        });
        return body;
    }
}

module.exports = MenuService;
