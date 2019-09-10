/* jshint indent: 2 */

module.exports = function (sequelize, DataTypes) {
    return sequelize.define('sys_main', {
        id: {
            type: DataTypes.STRING(32),
            allowNull: false,
            primaryKey: true
        },
        body_id: {
            type: DataTypes.STRING(64),
            allowNull: true
        },
        title: {
            type: DataTypes.STRING(64),
            allowNull: true
        },
        path: {
            type: DataTypes.STRING(255),
            allowNull: true
        },
        is_cdn: {
            type: DataTypes.CHAR(1),
            allowNull: true
        },
        remarks: {
            type: DataTypes.STRING(255),
            allowNull: true
        },
        createdAt: {
            field: 'created_at',
            type: DataTypes.DATE,
            allowNull: true
        },
        updatedAt: {
            field: 'updated_at',
            type: DataTypes.DATE,
            allowNull: true
        }
    }, {
        tableName: 'sys_main'
    });
};
