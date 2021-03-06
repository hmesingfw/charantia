'use strict';

const Service = require('egg').Service;

class Tag extends Service {
    async list({ offset = 0, limit = 10, where = {} }) {
        where = { ...where, ...this.ctx.helper.whereParams };
        return this.ctx.model.Sys.Tag.findAndCountAll({
            where,
            offset,
            limit,
            order: [['updated_at', 'DESC']],
        });
    }

    async create(tag) {
        return this.ctx.model.Sys.Tag.create(tag);
    }

    async update(id, updates) {
        const tag = await this.ctx.model.Sys.Tag.findByPk(id);
        if (!tag) {
            this.ctx.throw(404, 'user not found');
        }
        return tag.update(updates);
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
            const tag = await this.ctx.model.Sys.Tag.findByPk(idArr[i]);
            if (!tag) {
                body.err += 1;
            } else {
                body.suc += 1;
                tag.update(obj);
            }
        }
        return body;
    }

}

module.exports = Tag;
