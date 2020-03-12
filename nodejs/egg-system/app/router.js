'use strict';
const baseURL = '/api';
module.exports = app => {
    const { router, controller } = app;
    // app.resources('posts', '/posts', app.controller.post);
    router.resources('tag', baseURL + '/v1/tag', controller.sys.tag); // 标签管理
    router.resources('enum', baseURL + '/v1/enum', controller.sys.enum); // 枚举管理


    /* 生成单表 */
    router.resources('table', baseURL + '/v1/generate', controller.generate.table);
    router.get(baseURL + '/v1/generate-utils/get-tablename', controller.generate.tableUtils.getAllTableName); // 获取表名
    router.get(baseURL + '/v1/generate-utils/get-tablefield', controller.generate.tableUtils.getTableField); // 获取字段数据
    router.get(baseURL + '/v1/generate-utils/generate-page', controller.generate.tableUtils.generatePage); // 测试

};
