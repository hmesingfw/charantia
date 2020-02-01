'use strict';
const baseURL = '/api';
module.exports = app => {
    const { router, controller } = app;
    // app.resources('users', '/users', app.controller.user);
    // app.resources('posts', '/posts', app.controller.post);
    router.resources('tag', baseURL + '/v1/tag', controller.sys.tag);


    /* 生成单表 */
    router.get(baseURL + '/v1/generate/getTableName', controller.generate.tableName.getAllTableName);

};
