'use strict';
const moment = require('moment');
module.exports = app => {
    const { STRING, DATE, TEXT } = app.Sequelize;

    const Table = app.model.define('sys_generate_table', {
        id: {
            type: STRING(36),
            primaryKey: true,
            autoIncrement: true,
        },
        tableName: {
            type: STRING(128),
            field: 'table_name',
        },
        tableClass: {
            type: STRING(128),
            field: 'table_class',
        },
        comment: STRING(255),
        author: STRING(32),
        fieldList: {
            type: TEXT,
            field: 'field_list',
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
        details: STRING(255),
        userId: {
            type: STRING(36),
            field: 'user_id',
        },
        isDel: {
            type: STRING(1),
            field: 'is_del',
        },
    }, {
        freezeTableName: true, // 禁用修改表名
        tableName: 'sys_generate_table', // 数据库表名 ;
    });


    return Table;
};
