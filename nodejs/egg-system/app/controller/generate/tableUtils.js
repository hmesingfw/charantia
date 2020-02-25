'use strict';
const Controller = require('egg').Controller;

class TableUtilsController extends Controller {

    async getAllTableName() {
        const ctx = this.ctx;
        const list = await ctx.service.generate.tableUtils.getAllTableName();
        ctx.body = {
            count: list.length,
            rows: list,
        };
    }

    async getTableField() {
        const ctx = this.ctx;
        const tableName = ctx.query.name;
        const list = await ctx.service.generate.tableUtils.getTableFiled(tableName);
        ctx.body = {
            rows: list,
        };
    }
}

module.exports = TableUtilsController;
