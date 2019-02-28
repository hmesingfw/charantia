'use strict';

const Controller = require('egg').Controller;
const jwt = require('jsonwebtoken');

const fs = require('fs');

const privateKey = fs.readFileSync('./config/private.key');

class HomeController extends Controller {
  async login() {
    const {
      ctx,
    } = this;

    // Token 数据
    const payload = {
      name: 'wanghao',
      admin: true,
    };

    // 密钥
    // const secret = 'woshizhangsan';

    // 签发 Token
    const tokenRS256 = jwt.sign(payload, privateKey, {
      algorithm: 'RS256',
    });

    // 输出签发的 Token
    // console.log(tokenRS256);


    ctx.body = {
      data: 'hi, login',
      token: tokenRS256,
    };
  }
}

module.exports = HomeController;
