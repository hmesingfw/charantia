'use strict';

const Service = require('egg').Service;

class Table extends Service {
    async list({ offset = 0, limit = 10, where = {} }) {
        where = { ...where, ...this.ctx.helper.whereParams };
        return this.ctx.model.Generate.Table.findAndCountAll({
            where,
            offset,
            limit,
            order: [['updated_at', 'DESC']],
        });
    }

    async create(table) {
        return this.ctx.model.Generate.Table.create(table);
    }

    async show(id) {
        return this.ctx.model.Generate.Table.findByPk(id);
    }

    async update(id, body) {
        const item = await this.ctx.model.Generate.Table.findByPk(id);
        if (!item) {
            this.ctx.throw(404, 'user not found');
        }
        return item.update(body);
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
            const en = await this.ctx.model.Generate.Table.findByPk(idArr[i]);
            if (!en) {
                body.err += 1;
            } else {
                body.suc += 1;
                en.update(obj);
            }
        }
        return body;
    }
}
module.exports = Table;
