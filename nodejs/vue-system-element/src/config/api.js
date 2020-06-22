var baseURL = '/api';

export default {
    /* 系统管理 */
    sys: {
        tag: baseURL + '/v1/sys/tag',             // 系统标签
        enum: baseURL + '/pub/dict',              // 数据字典
        enumDetail: baseURL + '/pub/dict-item',   // 数据字典详情
        menu: baseURL + '/pub/menu',              // 系统菜单
        user: baseURL + '/pub/admin',             // 系统用户
        userPwd: baseURL + '/pub/admin/password', // 重置密码
        userLogin: baseURL + '/pub/admin/login',  // 系统用户登录

        tenant: baseURL + '/pub/tenant',          // 系统租户信息
        role: baseURL + '/sys/role',              // 租房角色信息
        roleMenu: baseURL + '/sys/role-menu',     // 租房角色信息
        roleUser: baseURL + '/sys/role-user',   // 角色用户关联

        tenantAdmin: baseURL + '/pub/tenant/admin',  // 系统用户登录

        config: baseURL + '/pub/config',          // 配置管理


        versionLog: baseURL + '/pub/version-log',          // 更新日志

        bizPage: baseURL + '/biz/page',          // 单页表

        dashboard: baseURL + '/pub/dashboard',          // 首页



        file: baseURL + '/v1/sys/file',           // 系统文件
        banner: baseURL + '/v1/sys/banner',       // 首页轮播

        getFile: baseURL + '/v1/sys/get-file',      // 获取文件信息 
    },
    message: {
        dict: baseURL + '/message/dict',                      // 消息字典
        category: baseURL + '/message/category',              // 消息分类
        action: baseURL + '/message/action',              // 消息行为
    },
    generate: {
        index: baseURL + '/v1/generate',                        // 代码生成表
        tableName: baseURL + '/v1/generate-utils/get-tablename',        // 
        tableField: baseURL + '/v1/generate-utils/get-tablefield',      // 跟据表名获取字段信息
        tableGenerate: baseURL + '/v1/generate-utils/generate-page',    // 生成代码
    }
};