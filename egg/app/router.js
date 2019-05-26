'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {

	const {
		router,
		controller,
	} = app;
	router.get('/', controller.home.index);
	// 登录验证
	router.get('/login/login', controller.login.index.login);
	router.get('/identity', controller.login.index.user);

	// 菜单设置
	router.get('/getMenus', controller.menus.index.getMenus);
	router.post('/addMenus', controller.menus.index.addMenus);
	router.post('/delMenus', controller.menus.index.delMenus);

};
