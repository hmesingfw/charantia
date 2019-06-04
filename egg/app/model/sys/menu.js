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
		titelZh: {
			field: 'title_zh',
			type: DataTypes.STRING(128),
			allowNull: true
		},
		titelEn: {
			field: 'title_en',
			type: DataTypes.STRING(128),
			allowNull: true
		},
		status: {
			type: DataTypes.STRING(10),
			allowNull: true
		},
		show: {
			type: DataTypes.STRING(1),
			allowNull: true
		},
		component: {
			type: DataTypes.STRING(255),
			allowNull: true
		},
		sort: {
			type: DataTypes.INTEGER(13),
			allowNull: true
		},
		icon: {
			type: DataTypes.TEXT,
			allowNull: true
		},
		user: {
			type: DataTypes.STRING(64),
			allowNull: true
		},
		createdAt: {
			field: 'created_at',
			type: DataTypes.DATE,
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
		// timestamps: false, // 禁止时间戳
		freezeTableName: true, // 禁用修改表名
		tableName: 'sys_menu', // 数据库表名 ;
		updatedAt: 'updatetime'
	});

	return Menu;
};
