var baseURL = '/api';

export default {
    /* 系统管理 */
    sys: {
        tag: baseURL + '/tag',             // 系统标签
        enum: baseURL + '/platform/dict',              // 数据字典
        enumDetail: baseURL + '/platform/dict/',   // 数据字典详情
        enumDetailList: baseURL + '/platform/dict/item',   // 数据字典详情  查询全部
        menu: baseURL + '/platform/menu',              // 系统菜单
        user: baseURL + '/platform/admin',             // 系统用户
        userPwd: baseURL + '/platform/admin', // 重置密码
        userLogin: baseURL + '/platform/admin/login',  // 平台系统用户登录

        tenant: baseURL + '/platform/tenant',          // 系统租户信息
        role: baseURL + '/sys/role',              // 租房角色信息
        roleMenu: baseURL + '/sys/role-menu',     // 租房角色信息
        roleUser: baseURL + '/sys/role-user',   // 角色用户关联

        tenantAdmin: baseURL + '/platform/tenant/admin',  // 系统租户

        config: baseURL + '/platform/config',          // 配置管理


        versionLog: baseURL + '/platform/version-log',          // 更新日志

        bizPage: baseURL + '/page',          // 单页表

        dashboard: baseURL + '/platform/dashboard',          // 首页
        ueditor: baseURL + '/ueditor',          // 首页

        upload: baseURL + '/attachment/upload', // 上传文件
        download: baseURL + '/attachment/download',     // 下载预览文件


        banner: baseURL + '/platform/banner-position',       // 广告位置 

        file: baseURL + '/v1/sys/file',           // 系统文件
    },
    menber: {
        login: baseURL + '/account/login',      // 登录
        article: baseURL + '/article',          // 资讯表
        articleCategory: baseURL + '/article-category',          // 资讯表  分类

        announce: baseURL + '/announce',        // 公告
        config: baseURL + '/config',             // 配置管理
        banner: baseURL + '/banner',             // 广告管理


        feed: baseURL + '/feed',             // 广告管理
    },
    message: {
        dict: baseURL + '/message-dict',                      // 消息字典
        category: baseURL + '/message-category',              // 消息分类
        action: baseURL + '/message-action',              // 消息行为
    },
    generate: {
        index: baseURL + '/v1/generate',                        // 代码生成表
        tableName: baseURL + '/v1/generate-utils/get-tablename',        // 
        tableField: baseURL + '/v1/generate-utils/get-tablefield',      // 跟据表名获取字段信息
        tableGenerate: baseURL + '/v1/generate-utils/generate-page',    // 生成代码
    }
};