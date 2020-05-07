'use strict';
const moment = require('moment');
module.exports = app => {
    const { STRING, DATE, INTEGER } = app.Sequelize;

    const File = app.model.define('sys_file', {
        id: {
            type: STRING(36),
            primaryKey: true,
            autoIncrement: true,
        },
        fileName: {
            type: STRING(128),
            field: 'file_name',
        },
        saveName: {
            type: STRING(32),
            field: 'save_name',
        },
        savePath: {
            type: STRING(255),
            field: 'save_path',
        },
        ext: STRING(10),
        mime: STRING(32),
        size: INTEGER(20),
        md5: STRING(32),
        sha: STRING(64),
        url: STRING(255),
        isImg: {
            type: STRING(1),
            field: 'is_img',
        },
        driver: STRING(32),

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
    }, {
        // timestamps: true, // 如果需要sequelize帮你维护createdAt,updatedAt和deletedAt必须先启用timestamps功能
        freezeTableName: true, // 禁用修改表名
        tableName: 'sys_file', // 数据库表名 ;
    });

    return File;
};
