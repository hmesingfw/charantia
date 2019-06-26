'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {

	const {
		router,
		controller,
	} = app;
	// 登录验证
	router.get('/login/login', controller.login.index.login);
	router.get('/identity', controller.login.index.user);

	// 菜单设置
	router.get('/getMenus', controller.menus.index.getMenus);
	router.post('/addMenus', controller.menus.index.addMenus);
	router.post('/delMenus', controller.menus.index.delMenus);


	// 获取数据库信息
	router.get('/getAllTableName', controller.sys.table.table.getAllTableName);
	router.get('/getTableFiled', controller.sys.table.table.getTableFiled);

	// 枚举管理
	router.post('/getAllEnum', controller.sys.enum.index.getAllEnum);
	router.post('/getEnum', controller.sys.enum.index.getEnum);
	router.post('/addEnum', controller.sys.enum.index.addEnum);
	router.post('/delEnum', controller.sys.enum.index.delEnum);


	// 生成模版
	router.get('/generate/index', controller.sys.generate.index.index);
};
