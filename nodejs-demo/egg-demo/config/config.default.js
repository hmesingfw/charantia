/* eslint valid-jsdoc: "off" */

'use strict';

/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = appInfo => {
    /**
     * built-in config
     * @type {Egg.EggAppConfig}
     **/
    const config = exports = {};

    // use for cookie sign key, should change to your own and keep security
    config.keys = appInfo.name + '_1586790742543_2271';

    // add your middleware config here
    config.middleware = [];

    // add your user config here
    const userConfig = {
        // myAppName: 'egg',
    };

    config.cluster = {
        listen: {
            path: '',
            port: 80,
            hostname: '0.0.0.0',
        },
    };
    config.view = {
        mapping: { '.ejs': 'ejs' },
    };
    return {
        ...config,
        ...userConfig,
    };
};
