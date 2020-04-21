'use strict';

const Service = require('egg').Service;

class Role extends Service {
    async list({ offset = 0, limit = 10, where = {} }) {
        where = { ...where, ...this.ctx.helper.whereParams };
        // const m = this;
        return this.ctx.model.Sys.Role.findAndCountAll({
            // include: [{ model: m.ctx.model.Sys.Role, as: 'menus', attributes: ['menuId'] }],
            where,
            offset,
            limit,
            order: [['updated_at', 'DESC']],
        });
    }

    async create(item) {
        return this.ctx.model.Sys.Role.create(item);
    }

    async update(id, updates) {
        const item = await this.ctx.model.Sys.Role.findByPk(id);
        if (!item) {
            this.ctx.throw(404, '找不到数据');
        }
        return item.update(updates);
    }

    async del(ids) {
        const body = {
            suc: 0,
            err: 0,
        };
        let idArr = [];
        ids.split(',').length > 0 ? idArr = ids.split(',') : idArr.push(ids);
        for (let i = 0; i < idArr.length; i++) {
            const obj = { id: idArr[i], isDel: '1' };
            const item = await this.ctx.model.Sys.Role.findByPk(idArr[i]);
            if (!item) {
                body.err += 1;
            } else {
                body.suc += 1;
                item.update(obj);
            }
        }
        return body;
    }

}

module.exports = Role;
