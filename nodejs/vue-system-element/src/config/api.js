var baseURL = '/api';

export default {
    /* 系统管理 */
    sys: {
        tag: baseURL + '/v1/tag',           // 系统标签
        enum: baseURL + '/v1/enum',           // 系统枚举
    },
    generate: {
        index: baseURL + '/v1/generate',                        // 代码生成表
        tableName: baseURL + '/v1/generate-utils/getTableName',       // 
        tableField: baseURL + '/v1/generate-utils/getTableField',       // 跟据表名获取字段信息
    }
};