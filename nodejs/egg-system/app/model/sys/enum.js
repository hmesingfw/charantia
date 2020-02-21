'use strict';
const moment = require('moment');
module.exports = app => {
    const { STRING, DATE } = app.Sequelize;

    const Enum = app.model.define('sys_enum', {
        id: {
            type: STRING(36),
            primaryKey: true,
            autoIncrement: true,
        },
        title: STRING(50),
        value: STRING(50),
        parentId: {
            type: STRING(36),
            field: 'parent_id',
        },
        status: STRING(1),
        sort: STRING(11),
        details: STRING(255),
        userId: {
            type: STRING(36),
            field: 'user_id',
        },
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
        isDel: {
            type: STRING(1),
            field: 'is_del',
        },
    }, {
        // timestamps: true, // 如果需要sequelize帮你维护createdAt,updatedAt和deletedAt必须先启用timestamps功能
        freezeTableName: true, // 禁用修改表名
        tableName: 'sys_enum', // 数据库表名 ;
    });


    return Enum;
};
