'use strict';
module.exports = app => {
    const { STRING } = app.Sequelize;

    const RoleUser = app.model.define('sys_role_user', {
        roleId: {
            type: STRING(36),
            primaryKey: true,
            // autoIncrement: true,    // 可用于创建自增的整数列
            field: 'role_id',
        },
        userId: {
            type: STRING(36),
            field: 'user_id',
        },

    }, {
        // timestamps: true, // 如果需要sequelize帮你维护createdAt,updatedAt和deletedAt必须先启用timestamps功能
        freezeTableName: true, // 禁用修改表名
        tableName: 'sys_role_user', // 数据库表名 ;
        // 我不想要 createdAt
        createdAt: false,
        updatedAt: false,
    });


    return RoleUser;
};
