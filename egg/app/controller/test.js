'use strict';

const Controller = require('egg').Controller;

class HomeController extends Controller {
  async index() {
    const { ctx } = this;
    const list = await this.ctx.model.Testuser.findAll();
    console.log(list);
    ctx.body = 'hi, egg';
  }
}

module.exports = HomeController;
