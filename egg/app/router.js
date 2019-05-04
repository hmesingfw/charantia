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
  router.get('/menus', controller.menus.index.getMenus);
};
