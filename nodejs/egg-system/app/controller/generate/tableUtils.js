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

    async testGen() {
        const ctx = this.ctx;
        console.log('------------------------------------------');
        const body = await ctx.renderView('generate/index.ejs', { data: 'hello' });
        console.log(body);
        ctx.body = {
            message: 'success',
        };
    }
}

module.exports = TableUtilsController;
