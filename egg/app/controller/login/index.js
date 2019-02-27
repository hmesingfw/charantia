'use strict';

const Controller = require('egg').Controller;
const jwt = require('jsonwebtoken');

const fs = require('fs');

const privateKey = fs.readFileSync('./config/private.key');
const pulicKey = fs.readFileSync('./config/public.key');

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
    const tokenRS256 = jwt.sign(payload, privateKey, { algorithm: 'RS256' });

    // 输出签发的 Token
    console.log(tokenRS256);

    // 验证 Token
    jwt.verify(tokenRS256, pulicKey, (error, decoded) => {
      if (error) {
        console.log(error.message);
        // return false;
      }
      console.log(decoded);
    });
    ctx.body = 'hi, login';
  }
}

module.exports = HomeController;