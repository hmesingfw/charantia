'use strict';
/* jshint indent: 2 */

module.exports = app => {
	const {
		DataTypes
	} = app.Sequelize;

	return app.model.define('sys_enum', {
		id: {
			type: DataTypes.STRING(32),
			allowNull: false,
			primaryKey: true
		},
		labelZh: {
			field: 'label_zh',
			type: DataTypes.STRING(100),
			allowNull: false
		},
		labelEn: {
			field: 'label_en',
			type: DataTypes.STRING(100),
			allowNull: false
		},
		value: {
			type: DataTypes.STRING(50),
			allowNull: false
		},
		type: {
			type: DataTypes.STRING(50),
			allowNull: false
		},
		createdAt: {
			field: 'created_at',
			type: DataTypes.DATE,
			allowNull: true
		},
		updatedUser: {
			field: 'updated_user',
			type: DataTypes.STRING(32),
			allowNull: true
		},
		updatedAt: {
			field: 'updated_at',
			type: DataTypes.DATE,
			allowNull: true
		},
		remark: {
			type: DataTypes.STRING(255),
			allowNull: true
		}
	}, {
		freezeTableName: true, // 禁用修改表名
		tableName: 'sys_enum'
	});
};