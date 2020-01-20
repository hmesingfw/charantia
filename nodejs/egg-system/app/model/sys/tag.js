'use strict';
const moment = require('moment');
module.exports = app => {
    const { STRING, INTEGER, DATE } = app.Sequelize;

    const Tag = app.model.define('sys_tag', {
        id: {
            type: STRING(36),
            primaryKey: true,
            autoIncrement: true,
        },
        title: STRING(32),
        type: STRING(255),
        color: STRING(255),
        sort: INTEGER(8),
        status: STRING(1),
        details: STRING(255),
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
        user_id: STRING(36),
    }, {
        // timestamps: true, // 如果需要sequelize帮你维护createdAt,updatedAt和deletedAt必须先启用timestamps功能
        freezeTableName: true, // 禁用修改表名
        tableName: 'sys_tag', // 数据库表名 ;
    });


    return Tag;
};
