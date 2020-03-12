'use strict';
const Controller = require('egg').Controller;
const path = require('path');
const fs = require('fs');

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

    async generatePage() {
        const ctx = this.ctx;
        const id = ctx.query.id;
        const info = await ctx.service.generate.table.show(id);

        const fieldList = JSON.parse(info.fieldList);
        // 匹配路径
        const filepath = path.join(path.resolve(), 'app', 'temp/') + info.tableClass + '.vue';
        console.log(fieldList);

        const queryList = fieldList.filter(item => {
            return item.isQuery;
        });
        const data = { fieldList, queryList };
        // 渲染模版
        const body = await ctx.renderView('generate/index.ejs', data);
        // 生成文件
        fs.writeFileSync(filepath, body);
        ctx.body = {
            message: 'success',
        };
    }
}

module.exports = TableUtilsController;
