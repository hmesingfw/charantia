'use strict';
const moment = require('moment');

module.exports = app => {
    const {
        STRING, TEXT, DATE, INTEGER,
    } = app.Sequelize;


    const Menu = app.model.define('sys_menu', {
        id: {
            type: STRING(36),
            allowNull: false,
            primaryKey: true,
        },
        parentId: {
            type: STRING(36),
            field: 'parent_id',
            defaultValue: '0',
        },
        path: {
            type: STRING(255),
            allowNull: true,
            defaultValue: '',
        },
        title: {
            type: STRING(128),
            allowNull: true,
        },
        status: {
            type: STRING(10),
            allowNull: true,
        },
        show: {
            type: STRING(1),
            allowNull: true,
        },
        component: {
            type: STRING(255),
            allowNull: true,
        },
        sort: {
            type: INTEGER(13),
            allowNull: true,
        },
        type: {
            type: STRING(1),
            allowNull: true,
        },
        par: {
            type: STRING(64),
            allowNull: true,
        },
        icon: {
            type: TEXT,
            allowNull: true,
        },
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
            defaultValue: '0',
        },
    }, {
        // timestamps: false, // 禁止时间戳
        freezeTableName: true, // 禁用修改表名
        tableName: 'sys_menu', // 数据库表名 ;
    });

    return Menu;
};
