'use strict';

const Controller = require('egg').Controller;
const jwt = require('jsonwebtoken');
const fs = require('fs');
const pulicKey = fs.readFileSync('./config/public.key');

class TestUserController extends Controller {
  async user() {
    const { ctx } = this;

    // const header = ctx.header;
    const token = ctx.get('token');
    console.log(token);

    // 验证 Token
    jwt.verify(token, pulicKey, (error, decoded) => {
      if (error) {
        console.log(error.message);
        // return false;
      }
      console.log(decoded);
    });
    ctx.body = {
      data: 'heiij',
    };
  }
}

module.exports = TestUserController;
