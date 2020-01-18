'use strict';

module.exports = app => {
    const { router, controller } = app;
    console.log(app);
    // app.resources('users', '/users', app.controller.user);
    // app.resources('posts', '/posts', app.controller.post);
    router.resources('tag', '/api/v1/tag', controller.sys.tag);
};
