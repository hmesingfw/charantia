'use strict';
// const JWT = require('jsonwebtoken');

module.exports = {
    userId() {
        console.log(this);
        // let obj;
        // try {
        //     // 验证当前token
        //     obj = JWT.verify(this.ctx.request.header.authorization, this.config.jwt.secret);
        // } catch (err) {
        //     console.log(err);
        // }
        // return obj && obj.id;
        return '----';
    },
};
