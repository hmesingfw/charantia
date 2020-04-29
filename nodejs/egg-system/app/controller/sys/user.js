'use strict';
const uuidv4 = require('uuid/v4');
const Controller = require('egg').Controller;
const JWT = require('jsonwebtoken');
class UserController extends Controller {
    async index() {
        const ctx = this.ctx;
        const query = {
            limit: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page),
            offset: ctx.helper.parseInt(ctx.query.size) * ctx.helper.parseInt(ctx.query.page - 1),
        };
        ctx.body = await ctx.service.sys.user.list(query);
    }

    async create() {
        const ctx = this.ctx;
        const bodys = ctx.request.body;
        bodys.id = uuidv4();
        const msg = await ctx.service.sys.user.create(bodys);
        ctx.body = {
            msg,
            message: '保存成功',
            code: 200,
        };
    }

    async update() {
        const ctx = this.ctx;
        const id = ctx.params.id;
        const body = ctx.request.body;
        const msg = await ctx.service.sys.user.update(id, body);
        ctx.body = {
            msg,
            message: '保存成功',
            code: 200,
        };
    }
    async destroy() {
        const ctx = this.ctx;
        const id = ctx.params.id;

        ctx.body = await ctx.service.sys.user.del(id);
        ctx.status = 200;
    }


    async login() {
        const ctx = this.ctx;
        const body = ctx.request.body.params;
        const query = {
            where: { phone: body.username },
            include: [{ model: this.app.model.Sys.RoleUser, as: 'role' }],
        };
        const userInfo = await ctx.service.sys.user.findOne(query);

        if (userInfo.password != body.password) { //eslint-disable-line
            ctx.body = { code: 4001, message: '账号密码输入错误，请重新输入' };
        } else if (userInfo.status === 1 || userInfo.is_del === 1) {
            ctx.body = { code: 4001, message: '账号已停用，请联系管理人员' };
        } else {
            let menus = [];
            if (userInfo.role && userInfo.role.roleId) {
                const roleid = userInfo.role.roleId;
                const roleInfo = await ctx.service.sys.role.roleMenuList({ roleId: roleid });


                // select * from sys_role_menu
                // left join sys_menu
                // on sys_role_menu.menu_id = sys_menu.id
                menus = await ctx.service.sys.menu.getTreeRole(roleInfo);

            }
            userInfo.setDataValue('role', {});
            const test = await ctx.service.sys.role.roletest();

            // 签发token
            const token = JWT.sign({
                id: userInfo.id,
                name: userInfo.name,
            }, this.config.jwt.secret, {
                expiresIn: 60 * 60,
            });
            ctx.body = {
                code: 200,
                token,
                message: '登录成功',
                info: userInfo,
                sysMenu: menus,
                test,
            };
        }


        ctx.status = 200;
    }

    async updateRole() {
        const ctx = this.ctx;
        const body = ctx.request.body;
        console.log(body, '----');
        const msg = await ctx.service.sys.role.updateRoleUser(body.userId, body);

        ctx.body = {
            msg,
            message: '保存成功',
            code: 200,
        };
        ctx.status = 200;
    }
}

module.exports = UserController;
