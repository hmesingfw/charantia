/* jshint indent: 2 */

module.exports = function (sequelize, DataTypes) {
  return sequelize.define('sys_enum', {
    id: {
      type: DataTypes.STRING(36),
      allowNull: false,
      primaryKey: true
    },
    title: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    value: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    group: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    remarks: {
      type: DataTypes.STRING(255),
      allowNull: true
    }
  }, {
    tableName: 'sys_enum',
    timestamps: true, // 禁止时间戳

  });
};