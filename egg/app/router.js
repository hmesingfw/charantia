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
	router.get('/getMenus', controller.sys.menus.getMenus);
	router.post('/addMenus', controller.sys.menus.addMenus);
	router.post('/delMenus', controller.sys.menus.delMenus);


	// 获取数据库信息
	router.get('/getAllTableName', controller.sys.table.getAllTableName);
	router.get('/getTableFiled', controller.sys.table.getTableFiled);

	// 枚举管理
	router.post('/getAllEnum', controller.sys.enum.getAllEnum);
	router.post('/getEnum', controller.sys.enum.getEnum);
	router.post('/addEnum', controller.sys.enum.addEnum);
	router.post('/delEnum', controller.sys.enum.delEnum);


	// 生成模版
	router.get('/generate/index', controller.sys.generate.index);

	// 样例
	router.post('/sys/datas', controller.sys.demo.datas);
	router.post('/sys/save', controller.sys.demo.save);
	router.post('/sys/delete', controller.sys.demo.delete);
};
