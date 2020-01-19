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

    async create(user) {
        return this.ctx.model.User.create(user);
    }

    async update({ id, updates }) {
        const user = await this.ctx.model.User.findByPk(id);
        if (!user) {
            this.ctx.throw(404, 'user not found');
        }
        return user.update(updates);
    }

    async del(id) {
        const user = await this.ctx.model.User.findByPk(id);
        if (!user) {
            this.ctx.throw(404, 'user not found');
        }
        return user.destroy();
    }
}

module.exports = Tag;
