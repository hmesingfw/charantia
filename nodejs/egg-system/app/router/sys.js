'use strict';
const baseURL = '/api';
module.exports = app => {
    const { router, controller } = app;

    router.resources('tag', baseURL + '/v1/sys/tag', controller.sys.tag); // 标签管理

    router.resources('enum', baseURL + '/v1/sys/enum', controller.sys.enum); // 枚举管理

    router.resources('menu', baseURL + '/v1/sys/menu', controller.sys.menu); // 系统菜单管理

    router.resources('user', baseURL + '/v1/sys/user', controller.sys.user); // 系统用户管理
    router.post(baseURL + '/v1/sys/user-login', controller.sys.user.login); // 用户登录
    router.post(baseURL + '/v1/sys/user-role', controller.sys.user.updateRole); // 保存用户角色

    router.resources('role', baseURL + '/v1/sys/role', controller.sys.role);
    router.post(baseURL + '/v1/sys/role-menu', controller.sys.role.updateMenus); // 角色保存菜单

    router.resources('file', baseURL + '/v1/sys/file', controller.sys.file); // 文件管理
    router.get(baseURL + '/v1/sys/get-file', controller.sys.file.getFile);

    router.resources('banner', baseURL + '/v1/sys/banner', controller.sys.banner);
};
