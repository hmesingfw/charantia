'use strict';
module.exports = app => {
    const { STRING } = app.Sequelize;

    const RoleMenu = app.model.define('sys_role_menu', {
        roleId: {
            type: STRING(36),
            primaryKey: true,
            // autoIncrement: true,    // 可用于创建自增的整数列
            field: 'role_id',
        },
        menuId: {
            type: STRING(4000),
            field: 'menu_id',
            get() {
                // eslint-disable-next-line no-eval
                return eval('(' + this.getDataValue('menuId') + ')');
            },
            set(val) {
                this.setDataValue('menuId', JSON.stringify(val));
            },
        },

    }, {
        // timestamps: true, // 如果需要sequelize帮你维护createdAt,updatedAt和deletedAt必须先启用timestamps功能
        freezeTableName: true, // 禁用修改表名
        tableName: 'sys_role_menu', // 数据库表名 ;
        // 我不想要 createdAt
        createdAt: false,
        updatedAt: false,
    });


    return RoleMenu;
};