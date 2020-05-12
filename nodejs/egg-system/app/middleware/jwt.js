'use strict';
const JWT = require('jsonwebtoken');
module.exports = options => {
    return async (ctx, next) => {
        // 拿到传会数据的header 中的token值
        const token = ctx.request.header.authorization;
        // const method = ctx.method.toLowerCase();
        // 当前请求时get请求，执行接下来的中间件
        const urls = ['/api/v1/sys/user-login', '/api/v1/sys/get-file'];

        if (urls.includes(ctx.path)) {
            await next();
        } else if (!token) {
            ctx.body = { msg: 'Token已过期', message: '身份会话已过期，请重新登录', code: 4001 };
            ctx.status = 200;
        } else { // 当前token值存在
            let decode;
            try {
                // 验证当前token
                decode = JWT.verify(token, options.secret);
                // console.log(decode);

                if (Date.now() - decode.expire > 0) {
                    ctx.body = { msg: 'Token已过期', message: '身份会话已过期，请重新登录', code: 4001 };
                    ctx.status = 200;
                }
                // const user = await ctx.model.User.find({
                //     userName: decode.userName,
                // });
                // if (user) {
                //     await next();
                // } else {
                //     ctx.throw('401', '用户信息验证失败');
                // }
                await next();
            } catch (e) {
                ctx.body = { msg: e, message: '身份认证已过期，请重新登录', code: 4001 };
                ctx.status = 200;
            }
        }
    };
};
