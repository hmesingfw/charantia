'use strict';
/* jshint indent: 2 */

module.exports = app => {
  const {
    DataTypes
  } = app.Sequelize;

  return app.model.define('sys_demo', {
    id: {
      type: DataTypes.STRING(64),
      allowNull: false,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(40),
      allowNull: true
    },
    sex: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    adress: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    code: {
      type: DataTypes.STRING(30),
      allowNull: true
    },
    createUser: {
      field: 'create_user',
      type: DataTypes.STRING(64),
    },
    created_at: {
      // field: 'created_at',
      type: DataTypes.DATE,
    },
    updateUser: {
      field: 'update_user',
      type: DataTypes.STRING(64),
    },
    updated_at: {
      // field: 'updated_at',
      type: DataTypes.DATE,
    },
    remarks: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    delFlag: {
      field: 'del_flag',
      type: DataTypes.CHAR(1),
      defaultValue: '0'
    }
  }, {
    tableName: 'sys_demo',
    freezeTableName: true, // 禁用修改表名
		// timestamps: false, // 禁止时间戳
  });
};
