'use strict';


const Controller = require('egg').Controller;


class TableController extends Controller {
    async getAllTableName() {
        const {
            ctx,
            service,
        } = this;

        ctx.body = await service.sys.table.getAllTableName();
    }

    async getTableFiled() {
        const {
            ctx,
            service
        } = this;

        const tableName = ctx.query.tableName;
        if (!tableName) {
            ctx.body = '参数错误：tableName未传';

        } else {
            ctx.body = await service.sys.table.getTableFiled(tableName);
        }
    }
}

module.exports = TableController;
