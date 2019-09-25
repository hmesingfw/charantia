/* jshint indent: 2 */
var moment = require('moment');
module.exports = function (sequelize, DataTypes) {
    return sequelize.define('sys_main', {
        id: {
            type: DataTypes.STRING(36),
            allowNull: false,
            primaryKey: true
        },
        bodyId: {
            field: 'body_id',
            type: DataTypes.STRING(36),
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
        isCdn: {
            field: 'is_cdn',
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
            allowNull: true,
            get() {
                return this.getDataValue('createdAt') ? moment(this.getDataValue('createdAt')).format('YYYY-MM-DD HH:mm:ss') : '';
            }
        },
        updatedAt: {
            field: 'updated_at',
            type: DataTypes.DATE,
            allowNull: true,
            get() {
                return this.getDataValue('updatedAt') ? moment(this.getDataValue('updatedAt')).format('YYYY-MM-DD HH:mm:ss') : '';
            }
        }
    }, {
        tableName: 'sys_main',
        // timestamps: true, // 禁止时间戳
        
    });
};
