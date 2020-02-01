'use strict';

const Controller = require('egg').Controller;

class TableNameController extends Controller {
    async getAllTableName() {
        const ctx = this.ctx;
        const list = await ctx.service.generate.tableName.getAllTableName();
        ctx.body = {
            count: list.length,
            rows: list,
        };
    }
}

module.exports = TableNameController;
