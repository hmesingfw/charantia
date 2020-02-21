'use strict';

const Service = require('egg').Service;

class Enum extends Service {
    async getTree(where) {
        where = { ...where, ...this.ctx.helper.whereParams };
        const rootNeeds = await this.ctx.model.Sys.Enum.findAll({
            where,
            order: [['sort', 'DESC'], ['updated_at', 'DESC']],
        });
        return await this.getChildNeeds(rootNeeds);
    }
    /* 树形结构 */
    async getChildNeeds(rootNeeds) {
        const expendPromise = [];
        rootNeeds.forEach(item => {
            expendPromise.push(this.ctx.model.Sys.Enum.findAll({
                where: {
                    ...this.ctx.helper.whereParams,
                    parentId: item.id,
                },
                order: [['sort', 'DESC'], ['updated_at', 'DESC']],
            }));
        });
        const child = await Promise.all(expendPromise);
        for (let [idx, item] of child.entries()) {

            if (item.length > 0) {
                item = await this.getChildNeeds(item);
            }
            rootNeeds[idx].setDataValue('children', item); // $$$ 在查询出来后的对象中赋值，需要使setDataValue方法
        }
        return rootNeeds;
    }


    async create(Enum) {
        return this.ctx.model.Sys.Enum.create(Enum);
    }

    async update(id, updates) {
        const item = await this.ctx.model.Sys.Enum.findByPk(id);
        if (!item) {
            this.ctx.throw(404, 'user not found');
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
