'use strict';
const moment = require('moment');
module.exports = app => {
    const { STRING, DATE } = app.Sequelize;

    const User = app.model.define('sys_user', {
        id: {
            type: STRING(36),
            primaryKey: true,
            autoIncrement: true,
        },
        phone: STRING(16),
        password: STRING(32),
        name: STRING(128),
        status: STRING(1),

        createdAt: {
            type: DATE,
            field: 'created_at',
            get() {
                return moment(this.getDataValue('createdAt')).format('YYYY-MM-DD HH:mm:ss');
            },
        },
        updatedAt: {
            field: 'updated_at',
            type: DATE,
            get() {
                return moment(this.getDataValue('updatedAt')).format('YYYY-MM-DD HH:mm:ss');
            },
        },
        userId: {
            type: STRING(36),
            field: 'user_id',
        },
        details: STRING(255),
        isDel: {
            type: STRING(1),
            field: 'is_del',
            defaultValue: '0',
        },

    }, {
        // timestamps: true, // 如果需要sequelize帮你维护createdAt,updatedAt和deletedAt必须先启用timestamps功能
        freezeTableName: true, // 禁用修改表名
        tableName: 'sys_user', // 数据库表名 ;
    });

    User.associate = function () {
        app.model.Sys.User.hasOne(app.model.Sys.RoleUser, { as: 'role', foreignKey: 'userId' });

    };

    return User;
};
