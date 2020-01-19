'use strict';

module.exports = app => {
    const { STRING, INTEGER, DATE } = app.Sequelize;

    const Tag = app.model.define('sys_tag', {
        id: {
            type: INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        title: STRING(32),
        type: STRING(255),
        color: STRING(255),
        sort: STRING(255),
        details: STRING(255),
        created_at: DATE,
        updated_at: DATE,
        user_id: STRING(36),
    }, {
        // timestamps: false, // 禁止时间戳
        freezeTableName: true, // 禁用修改表名
        tableName: 'sys_tag', // 数据库表名 ;
    });


    return Tag;
};
