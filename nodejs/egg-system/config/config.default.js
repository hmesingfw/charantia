'use strict';

module.exports = appInfo => {
    const config = exports = {};

    // use for cookie sign key, should change to your own and keep security
    config.keys = appInfo.name + '_nihaoa_woxihuannia';
    /* jwt 配置 */
    config.jwt = {
        secret: 'egg-api-jwt-wohaoxiangshizaijiamiai',
    };
    // add your config here
    config.middleware = ['jwt'];
    config.security = {
        csrf: {
            headerName: 'x-csrf-token', // 通过 header 传递 CSRF token 的默认字段为 x-csrf-token
        },
    };
    // change to your own sequelize configurations
    config.sequelize = {
        datasources: [{
            delegate: 'model', // load all models to app.model and ctx.model
            baseDir: 'model', // load models from `app/model/*.js`
            username: 'root',
            password: 'woxihuanni',
            database: 'charantia_sys',
            host: 'localhost',
            post: 3306,
            dialect: 'mysql',
        },
            // {        // 配置多个数据库
            // delegate: 'admninModel', // load all models to app.model and ctx.model
            // baseDir: 'admnin_model', // load models from `app/model/*.js`
            // username: 'root',
            // password: 'jeff1234',
            // database: 'consult_online',
            // host: '172.18.15.5',
            // post: 3306,
            // dialect: 'mysql',
            // }
        ],
    };

    config.view = {
        mapping: { '.ejs': 'ejs' },
    };


    return config;
};
