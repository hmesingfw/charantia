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

        tenantAdmin: baseURL + '/pub/tenant/admin',  // 系统用户登录


        file: baseURL + '/v1/sys/file',           // 系统文件
        banner: baseURL + '/v1/sys/banner',       // 首页轮播


        roleMenu: baseURL + '/v1/sys/role-menu',   // 角色菜单关联
        roleUser: baseURL + '/v1/sys/user-role',   // 角色用户关联
        getFile: baseURL + '/v1/sys/get-file',      // 获取文件信息 
    },
    message: {
        dict: baseURL + '/message/dict',                      // 消息字典
        category: baseURL + '/message/category',              // 消息分类
    },
    generate: {
        index: baseURL + '/v1/generate',                        // 代码生成表
        tableName: baseURL + '/v1/generate-utils/get-tablename',        // 
        tableField: baseURL + '/v1/generate-utils/get-tablefield',      // 跟据表名获取字段信息
        tableGenerate: baseURL + '/v1/generate-utils/generate-page',    // 生成代码
    }
};