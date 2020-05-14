'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
    const { router, controller } = app;
    router.get('/video', controller.home.index);
    router.get('/new', controller.home.newvide);
    router.get('/dofeng', controller.home.dofeng);
    router.get('/getcode', controller.home.getCode);
};
