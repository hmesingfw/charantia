'use strict';

const Service = require('egg').Service;

class Enum extends Service {
    async list({ offset = 0, limit = 10, where = {} }) {
        where = { ...where, ...this.ctx.helper.whereParams };
        return this.ctx.model.Sys.Enum.findAndCountAll({
            where,
            offset,
            limit,
            order: [['updated_at', 'DESC']],
        });
    }

    async create(Enum) {
        return this.ctx.model.Sys.Enum.create(Enum);
    }

    async update({ id, updates }) {
        const user = await this.ctx.model.Sys.Enum.findByPk(id);
        if (!user) {
            this.ctx.throw(404, 'user not found');
        }
        return user.update(updates);
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
            const en = await this.ctx.model.Sys.Enum.findByPk(idArr[i]);
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

module.exports = Enum;
