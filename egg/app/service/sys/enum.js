'use strict';

const Service = require('egg').Service;
const SysUtils = require('../../utils/sys');
const sysutils = new SysUtils();

class EnumService extends Service {
    /**
     * 查询枚举数据
     * @param {*} condition 查询条件
     */
    async getAllEnum(condition) {
        console.log(condition);
        const body = {
            data: await this.ctx.model.Sys.Enum.findAll({
                // where: condition.query,
                offset: (condition.currentPage - 1) * condition.pageSize,
                limit: condition.currentPage * condition.pageSize,
                order: [
                    [ 'updated_at', 'ASC' ],
                    [ 'type', 'DESC' ],
                ],
            }),
            totle: await this.ctx.model.Sys.Enum.count(),
        };
        return body;
    }

    /**
     * 添加或更新菜单
     * @param {*} form 表单信息
     */
    async addEnum(form) {
        // const form = this.ctx.request.body;
        let body;
        if (form.id) {
            body = await this.ctx.model.Sys.Enum.update({
                ...form
            }, {
                where: {
                    id: form.id
                }
            });
            if (body.length > 1) {
                body = '1';
            }
        } else {
            body = await this.ctx.model.Sys.Enum.create({
                id: sysutils.UUID(),
                ...form
            });
            if (body) {
                body = '1';
            }
        }
        return body;
    }

    /**
     * 删除枚举
     * @param {*} id 枚举ID
     */
    async delEnum(id) {
        const body = await this.ctx.model.Sys.Enum.destroy({
            where: {
                id
            }
        });
        return body;
    }
}

module.exports = EnumService;