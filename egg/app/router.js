'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {

  const { router, controller } = app;
  router.get('/', controller.home.index);
  router.get('/login/login', controller.login.index.login);
  router.get('/identity', controller.login.testUser.user);
};
