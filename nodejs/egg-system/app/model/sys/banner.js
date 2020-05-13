'use strict';
const moment = require('moment');
module.exports = app => {
    const { STRING, INTEGER, DATE } = app.Sequelize;

    const Banner = app.model.define('sys_banner', {
        id: {
            type: STRING(36),
            primaryKey: true,
            autoIncrement: true,
        },
        title: STRING(32),
        coverId: {
            type: STRING(36),
            field: 'cover_id',
        },
        startDate: {
            type: DATE,
            field: 'start_date',
            get() {
                return moment(this.getDataValue('startDate')).format('YYYY-MM-DD HH:mm:ss');
            },
        },
        endDate: {
            type: DATE,
            field: 'end_date',
            get() {
                return moment(this.getDataValue('endDate')).format('YYYY-MM-DD HH:mm:ss');
            },
        },
        sort: INTEGER(10),

        status: STRING(1),
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
        tableName: 'sys_banner', // 数据库表名 ;
    });


    return Banner;
};
