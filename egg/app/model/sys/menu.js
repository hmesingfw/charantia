'use strict';
/* jshint indent: 2 */

module.exports = app => {
	const {
		DataTypes
	} = app.Sequelize;


	const Menu = app.model.define('sys_menu', {
		id: {
			type: DataTypes.STRING(64),
			allowNull: false,
			primaryKey: true,
		},
		parentid: {
			type: DataTypes.STRING(64),
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
		timestamps: false,
		freezeTableName: true,
		tableName: 'sys_menu'
	});

	return Menu;
};
