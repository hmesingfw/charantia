var baseURL = '/api';

export default {
    /* 系统管理 */
    sys: {
        tag: baseURL + '/v1/sys/tag',             // 系统标签
        enum: baseURL + '/v1/sys/enum',           // 系统枚举
        menu: baseURL + '/v1/sys/menu',           // 系统枚举
        user: baseURL + '/v1/sys/user',           // 系统用户
        role: baseURL + '/v1/sys/role',           // 系统角色
        file: baseURL + '/v1/sys/file',           // 系统角色

        userLogin: baseURL + '/v1/sys/user-login', // 用户登录
        roleMenu: baseURL + '/v1/sys/role-menu',   // 角色菜单关联
        roleUser: baseURL + '/v1/sys/user-role',   // 角色用户关联
        getFile: baseURL + '/v1/sys/get-file',      // 获取文件信息 
    },
    generate: {
        index: baseURL + '/v1/generate',                        // 代码生成表
        tableName: baseURL + '/v1/generate-utils/get-tablename',        // 
        tableField: baseURL + '/v1/generate-utils/get-tablefield',      // 跟据表名获取字段信息
        tableGenerate: baseURL + '/v1/generate-utils/generate-page',    // 生成代码
    }
};