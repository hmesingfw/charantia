'use strict';

const Service = require('egg').Service;
const Sequelize = require('sequelize');
const Op = Sequelize.Op;

class MenuService extends Service {
    async getTree(where) {
        where = { ...where, ...this.ctx.helper.whereParams, parentId: '0' };
        const rootNeeds = await this.ctx.model.Sys.Menu.findAll({
            where,
            order: [['sort', 'DESC'], ['updated_at', 'DESC']],
        });
        return await this.getChildNeeds(rootNeeds, where);
    }
    /* 树形结构 */
    async getChildNeeds(rootNeeds, where) {
        const expendPromise = [];
        rootNeeds.forEach(item => {
            expendPromise.push(this.ctx.model.Sys.Menu.findAll({
                where: {
                    ...where,
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

    async create(Menu) {
        return this.ctx.model.Sys.Menu.create(Menu);
    }

    async update(id, updates) {
        const item = await this.ctx.model.Sys.Menu.findByPk(id);
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
            const en = await this.ctx.model.Sys.Menu.findByPk(idArr[i]);
            if (!en) {
                body.err += 1;
            } else {
                body.suc += 1;
                en.update(obj);
            }
        }
        return body;
    }
    /* 菜单用户权限 */
    async getTreeRole(roleId) {
        const where = { ...this.ctx.helper.whereParams, parentId: '0' };
        const rootNeeds = await this.ctx.model.Sys.Menu.findAll({
            include: [{
                model: this.app.model.Sys.RoleMenu, as: 'menus',
                where: { roleId },
            }],
            where,
            order: [['sort', 'DESC']],
        });
        return await this.getChildNeedsRole(rootNeeds, roleId);
    }
    /* 树形结构 */
    async getChildNeedsRole(rootNeeds, roleId) {
        const expendPromise = [];

        rootNeeds.forEach(item => {
            expendPromise.push(this.ctx.model.Sys.Menu.findAll({
                include: [{
                    model: this.app.model.Sys.RoleMenu, as: 'menus',
                    where: { roleId },
                }],
                where: {
                    ...this.ctx.helper.whereParams,
                    parentId: item.id,
                    status: '0',
                    type: {
                        [Op.ne]: '3',
                    },
                },
                order: [['sort', 'DESC']],
            }));
        });
        const child = await Promise.all(expendPromise);
        for (let [idx, item] of child.entries()) {

            if (item.length > 0) {
                item = await this.getChildNeedsRole(item, roleId);
            }
            rootNeeds[idx].setDataValue('children', item); // $$$ 在查询出来后的对象中赋值，需要使setDataValue方法
        }
        return rootNeeds;
    }

    /* 菜单用户按钮权限 */
    async getTreeRoleHandle(roleId, body) {
        const where = { ...body, ...this.ctx.helper.whereParams };
        return await this.ctx.model.Sys.Menu.findAll({
            include: [{
                model: this.app.model.Sys.RoleMenu, as: 'menus',
                where: { roleId },
            }],
            where,
            order: [['sort', 'DESC']],
        });
    }
}

module.exports = MenuService;
