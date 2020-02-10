var baseURL = '/api';

export default {
    /* 系统管理 */
    sys: {
        tag: baseURL + '/v1/tag',           // 系统标签
        enum: baseURL + '/v1/enum',           // 系统枚举
    },
    generate: {
        tableName: baseURL + '/v1/generate/getTableName',       // 
        tableField: baseURL + '/v1/generate/getTableField',       // 跟据表名获取字段信息
    }
};