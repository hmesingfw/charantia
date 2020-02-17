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

    async getTree(where) {
        where = { ...where, ...this.ctx.helper.whereParams };
        let rootNeeds = await this.ctx.model.Sys.Enum.findAll({
            where,
        });
        rootNeeds = await this.getChildNeeds(rootNeeds);
        return rootNeeds;
    }

    async getChildNeeds(rootNeeds) {
        for (let i = 0; i < rootNeeds.length; i++) {
            const item = rootNeeds[i];

            rootNeeds[i].children = await this.ctx.model.Sys.Enum.findAll({
                where: {
                    ...this.ctx.helper.whereParams,
                    parentId: item.id,
                },
            });
        }

        // const expendPromise = [];
        // rootNeeds.forEach(item => {
        //     expendPromise.push(this.ctx.model.Sys.Enum.findAll({
        //         where: {
        //             ...this.ctx.helper.whereParams,
        //             parentId: item.id,
        //         },
        //     }));
        // });
        // const child = await Promise.all(expendPromise);
        // for (let [idx, item] of child.entries()) {

        //     if (item.length > 0) {
        //         item = await this.getChildNeeds(item);
        //     }
        //     rootNeeds[idx].children = [{ id: 1 }];
        // }
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
