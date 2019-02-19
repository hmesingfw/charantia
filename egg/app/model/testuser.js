'use strict';
module.exports = app => {
  const {
    INTEGER,
    STRING,
  } = app.Sequelize;
  const Testuser = app.model.define('testuser', {
    id: {
      type: INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    name: {
      type: STRING(100),
      allowNull: false,
    },
  }, {
    freezeTableName: true,
    tableName: 'testuser',
    timestamps: false,
  });
  return Testuser;
};
