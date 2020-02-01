'use strict';

const Service = require('egg').Service;

class Tag extends Service {
    async list({ offset = 0, limit = 10 }) {
        return this.ctx.model.Sys.Tag.findAndCountAll({
            offset,
            limit,
            order: [['updated_at', 'DESC']],
        });
    }

    async find(id) {
        const user = await this.ctx.model.User.findByPk(id);
        if (!user) {
            this.ctx.throw(404, 'user not found');
        }
        return user;
    }

    async create(tag) {
        return this.ctx.model.Sys.Tag.create(tag);
    }

    async update({ id, updates }) {
        const user = await this.ctx.model.Sys.Tag.findByPk(id);
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
            const tag = await this.ctx.model.Sys.Tag.findByPk(idArr[i]);
            if (!tag) {
                body.err += 1;
            } else {
                body.suc += 1;
                tag.destroy();
            }
        }
        return body;
    }

}

module.exports = Tag;
