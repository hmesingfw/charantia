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
}
module.exports = Table;
