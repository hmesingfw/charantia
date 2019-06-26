'use strict';

const Service = require('egg').Service;
const SysUtils = require('../../utils/sys');
const sysutils = new SysUtils();

class EnumService extends Service {
    /**
     * 查询枚举数据
     */
    async getAllEnum() {
        const body = {
            data: await this.ctx.model.Sys.Enum.findAll({
                order: [
                    [ 'type', 'DESC' ],
                ],
            }),
        };
        return body;
    }

    /**
     * 查询枚举数据
     * @param {*} condition 查询条件
     */
    async getEnum(condition) {
        let where = {};
        // 过滤空值
        if (condition.query.labelZh) {
            where.labelZh = sysutils.ProcessQueryValues(condition.query.labelZh);
        }

        if (condition.query.labelEn) {
            where.labelEn = sysutils.ProcessQueryValues(condition.query.labelEn);
        }

        if (condition.query.type) {
            where.type = condition.query.type;
        }

        const body = {
            data: await this.ctx.model.Sys.Enum.findAll({
                where: where,
                offset: (condition.currentPage - 1) * condition.pageSize,
                limit: condition.pageSize,
                order: [
                    [ 'type', 'DESC' ],
                ],
            }),
            total: await this.ctx.model.Sys.Enum.count(),
            typeList: await this.ctx.model.Sys.Enum.findAll({
                attributes: [ 'type' ],
                group: 'type'
            })
        };
        return body;
    }

    /**
     * 添加或更新菜单
     * @param {*} form 表单信息
     */
    async addEnum(form) {
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