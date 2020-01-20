'use strict';

module.exports = appInfo => {
    const config = exports = {};

    // use for cookie sign key, should change to your own and keep security
    config.keys = appInfo.name + '_nihaoa_woxihuannia';

    // add your config here
    config.middleware = [];
    config.security = {
        csrf: {
            headerName: 'x-csrf-token', // 通过 header 传递 CSRF token 的默认字段为 x-csrf-token
        },
    };
    // change to your own sequelize configurations
    config.sequelize = {
        username: 'root',
        password: 'woxihuanni',
        database: 'charantia_sys',
        host: 'localhost',
        post: 3306,
        dialect: 'mysql',
    };


    return config;
};
