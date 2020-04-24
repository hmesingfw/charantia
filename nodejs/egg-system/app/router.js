'use strict';
const baseURL = '/api';
module.exports = app => {
    const { router, controller } = app;
    // app.resources('posts', '/posts', app.controller.post);
    router.resources('tag', baseURL + '/v1/sys/tag', controller.sys.tag); // 标签管理

    router.resources('enum', baseURL + '/v1/sys/enum', controller.sys.enum); // 枚举管理

    router.resources('menu', baseURL + '/v1/sys/menu', controller.sys.menu); // 系统菜单管理

    router.resources('user', baseURL + '/v1/sys/user', controller.sys.user); // 系统用户管理
    router.post(baseURL + '/v1/sys/user-login', controller.sys.user.login); // 用户登录
    router.post(baseURL + '/v1/sys/user-role', controller.sys.user.updateRole); // 保存用户角色

    router.resources('role', baseURL + '/v1/sys/role', controller.sys.role);
    router.post(baseURL + '/v1/sys/role-menu', controller.sys.role.updateMenus); // 角色保存菜单

    /* 生成单表 */
    router.resources('table', baseURL + '/v1/generate', controller.generate.table);
    router.get(baseURL + '/v1/generate-utils/get-tablename', controller.generate.tableUtils.getAllTableName); // 获取表名
    router.get(baseURL + '/v1/generate-utils/get-tablefield', controller.generate.tableUtils.getTableField); // 获取字段数据
    router.get(baseURL + '/v1/generate-utils/generate-page', controller.generate.tableUtils.generatePage); // 测试

};
