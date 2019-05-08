'use strict';
/* jshint indent: 2 */

module.exports = app => {
	const {
		DataTypes
	} = app.Sequelize;


	const Menu = app.model.define('sys_menu', {
		id: {
			type: DataTypes.STRING(32),
			allowNull: false,
			primaryKey: true,
		},
		parentid: {
			type: DataTypes.STRING(32),
			allowNull: true,
			defaultValue: '0'
		},
		path: {
			type: DataTypes.STRING(255),
			allowNull: true,
			defaultValue: ''
		},
		title: {
			type: DataTypes.STRING(64),
			allowNull: true
		},
		sort: {
			type: DataTypes.INTEGER(13),
			allowNull: true
		},
		meta: {
			type: DataTypes.TEXT,
			allowNull: true
		},
		user: {
			type: DataTypes.STRING(64),
			allowNull: true
		},
		updatetime: {
			type: DataTypes.DATE,
			allowNull: true
		},
		remark: {
			type: DataTypes.STRING(255),
			allowNull: true
		}
	}, {
		timestamps: false,		// 禁止时间戳
		freezeTableName: true,	// 禁用修改表名
		tableName: 'sys_menu',	// 数据库表名 ;
	});

	return Menu;
};
