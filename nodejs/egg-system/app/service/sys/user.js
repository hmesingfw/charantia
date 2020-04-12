'use strict';

const Service = require('egg').Service;

class User extends Service {
    async list({ offset = 0, limit = 10, where = {} }) {
        where = { ...where, ...this.ctx.helper.whereParams };
        return this.ctx.model.Sys.User.findAndCountAll({
            where,
            offset,
            limit,
            order: [['updated_at', 'DESC']],
        });
    }

    async create(user) {
        return this.ctx.model.Sys.User.create(user);
    }

    async find(user) {
        return this.ctx.model.Sys.User.findAll(user);
    }

    async update(id, updates) {
        const user = await this.ctx.model.Sys.User.findByPk(id);
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
            const user = await this.ctx.model.Sys.User.findByPk(idArr[i]);
            if (!user) {
                body.err += 1;
            } else {
                body.suc += 1;
                user.update(obj);
            }
        }
        return body;
    }

}

module.exports = User;
