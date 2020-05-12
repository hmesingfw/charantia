'use strict';

const Service = require('egg').Service;
const fs = require('fs');
const path = require('path');

class File extends Service {
    async list({ offset = 0, limit = 10, where = {} }) {

        return this.ctx.model.Sys.File.findAndCountAll({
            where,
            offset,
            limit,
            order: [['updated_at', 'DESC']],
        });
    }

    async create(file) {
        return this.ctx.model.Sys.File.create(file);
    }

    async find(id) {
        const file = await this.ctx.model.Sys.File.findByPk(id);
        if (!file) {
            this.ctx.throw(404, 'fild not found');
        }
        return file;
    }

    async update(id, updates) {
        const file = await this.ctx.model.Sys.File.findByPk(id);
        if (!file) {
            this.ctx.throw(404, 'fild not found');
        }
        return file.update(updates);
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
            const file = await this.ctx.model.Sys.File.findByPk(idArr[i]);
            if (!file) {
                body.err += 1;
            } else {
                body.suc += 1;
                file.destroy(obj);

                /* 删除文件 */
                try {
                    const target = path.join('./app/public/', file.savePath);
                    fs.unlinkSync(target);
                } catch (error) {
                    this.logger.info(error);
                }
            }
        }
        return body;
    }

}

module.exports = File;
