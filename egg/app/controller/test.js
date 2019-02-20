'use strict';

const Controller = require('egg').Controller;

class HomeController extends Controller {
  async index() {
    const { ctx } = this;
    const list = await this.ctx.model.models.znew.findAll();
    ctx.body = list;
  }
}

module.exports = HomeController;
