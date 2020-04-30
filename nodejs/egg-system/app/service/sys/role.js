'use strict';

const Service = require('egg').Service;
const sequelize = require('sequelize');
class Role extends Service {
    async list({ offset = 0, limit = 10, where = {} }) {
        where = { ...where, ...this.ctx.helper.whereParams };
        let array = [];
        try {
            array = await this.ctx.model.Sys.Role.findAndCountAll({
                attributes: {
                    include: [[sequelize.col('user.name'), 'userName']],
                },
                include: [{
                    model: this.app.model.Sys.User, as: 'user',
                }],
                where,
                offset,
                limit,
                order: [['updated_at', 'DESC']],
            });
        } catch (error) {
            console.log(error);
        }

        const expendPromise = [];

        array.rows.forEach(async item => {
            expendPromise.push(this.app.model.Sys.RoleMenu.findAll({ where: { roleId: item.id } }));
        });
        const child = await Promise.all(expendPromise); /* 没想明白这一步的目的 */
        for (const [idx, item] of child.entries()) {
            array.rows[idx].setDataValue('menus', item);
        }

        return array;
    }

    async create(item) {
        return this.ctx.model.Sys.Role.create(item);
    }

    async update(id, updates) {
        const item = await this.ctx.model.Sys.Role.findByPk(id);
        if (!item) {
            this.ctx.throw(404, '找不到数据');
        }
        updates.userId = this.ctx.helper.userId();
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
            const item = await this.ctx.model.Sys.Role.findByPk(idArr[i]);
            if (!item) {
                body.err += 1;
            } else {
                body.suc += 1;
                item.update(obj);
            }
        }
        return body;
    }
    /* 保存角色与菜单 */
    async updateRoleMenu(roleId, menus) {
        /* 删除所有 */
        await this.ctx.model.Sys.RoleMenu.destroy({ where: { roleId } });

        menus.forEach(async id => {
            const data = { roleId, menuId: id };
            await this.ctx.model.Sys.RoleMenu.create(data);
        });
        return '成功';
    }

    /* 根据角色查询权限 */
    async roleMenuList(role) {
        return await this.ctx.model.Sys.RoleMenu.findAll(role);
    }

    /* 保存角色与用户 */
    async updateRoleUser(id, updates) {
        const item = await this.ctx.model.Sys.RoleUser.findOne({ where: { userId: id } });
        if (!item) {
            return await this.ctx.model.Sys.RoleUser.create(updates);
        }
        return await this.ctx.model.Sys.RoleUser.update({ roleId: updates.roleId }, { where: { userId: id } });
    }


}

module.exports = Role;
