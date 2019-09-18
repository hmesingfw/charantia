/* jshint indent: 2 */

module.exports = function (sequelize, DataTypes) {
    return sequelize.define('sys_body', {
        id: {
            type: DataTypes.STRING(36),
            allowNull: false,
            primaryKey: true
        },
        body: {
            type: DataTypes.TEXT,
            allowNull: true
        }
    }, {
        tableName: 'sys_body',
        timestamps: false, // 禁止时间戳  false 禁止添加
    });
};
