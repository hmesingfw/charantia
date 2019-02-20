'use strict';
/* jshint indent: 2 */

module.exports = app => {
  const {
    INTEGER,
    STRING,
    TEXT,
    DATE,
    CHAR,
  } = app.Sequelize;

  const Znew = app.model.define('znew', {
    id: {
      type: STRING(64),
      allowNull: false,
      primaryKey: true,
    },
    title: {
      type: STRING(200),
      allowNull: true,
    },
    introduce: {
      type: STRING(400),
      allowNull: true,
    },
    img: {
      type: STRING(400),
      allowNull: true,
    },
    iscommend: {
      type: STRING(10),
      allowNull: true,
    },
    weight: {
      type: INTEGER(11),
      allowNull: true,
    },
    click: {
      type: INTEGER(11),
      allowNull: true,
    },
    content: {
      type: TEXT,
      allowNull: true,
    },
    create_by: {
      type: STRING(64),
      allowNull: true,
    },
    create_date: {
      type: DATE,
      allowNull: true,
    },
    update_by: {
      type: STRING(64),
      allowNull: true,
    },
    update_date: {
      type: DATE,
      allowNull: true,
    },
    remarks: {
      type: STRING(255),
      allowNull: true,
    },
    del_flag: {
      type: CHAR(1),
      allowNull: true,
    },
  }, {
    freezeTableName: true,
    tableName: 'znew',
    timestamps: false,
  });
  return Znew;
};
