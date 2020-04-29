'use strict';
module.exports = app => {
    const { STRING, INTEGER } = app.Sequelize;

    const RoleMenu = app.model.define('sys_role_menu', {
        id: {
            type: INTEGER,

            primaryKey: true,
            autoIncrement: true, // 可用于创建自增的整数列
        },
        roleId: {
            type: STRING(36),
            field: 'role_id',
        },
        menuId: {
            type: STRING(36),
            field: 'menu_id',

        },

    }, {
        // timestamps: true, // 如果需要sequelize帮你维护createdAt,updatedAt和deletedAt必须先启用timestamps功能
        freezeTableName: true, // 禁用修改表名
        tableName: 'sys_role_menu', // 数据库表名 ;
        // 我不想要 createdAt
        createdAt: false,
        updatedAt: false,
    });
    RoleMenu.associate = function () {
        app.model.Sys.RoleMenu.hasOne(app.model.Sys.Menu, { foreignKey: 'id', sourceKey: 'menuId' });

    };


    return RoleMenu;
};
