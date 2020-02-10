'use strict';
const baseURL = '/api';
module.exports = app => {
    const { router, controller } = app;
    // app.resources('users', '/users', app.controller.user);
    // app.resources('posts', '/posts', app.controller.post);
    router.resources('tag', baseURL + '/v1/tag', controller.sys.tag); // 标签管理
    router.resources('enum', baseURL + '/v1/enum', controller.sys.enum); // 枚举管理


    /* 生成单表 */
    router.get(baseURL + '/v1/generate/getTableName', controller.generate.tableName.getAllTableName);
    router.get(baseURL + '/v1/generate/getTableField', controller.generate.tableName.getTableField);

};
