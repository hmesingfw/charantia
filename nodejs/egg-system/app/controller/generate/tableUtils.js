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
        const filepath = path.join(path.resolve(), 'app', 'temp/') + info.tableClass;


        const queryList = [];
        const queryHiddenList = {};
        const tableList = [];
        const formList = [];
        const formEnum = []; //  表单枚举值
        fieldList.forEach(item => {
            /* 查询 */
            if (item.isQuery) {
                /* 查询展示字段 */
                const obj = { name: item.component, key: item.alias, label: item.comment, attr: { placeholder: '请输入内容' } };
                if (['el-select', 'el-switch'].includes(item.component)) {
                    obj.option = item.enumType;
                    obj.attr = {
                        placeholder: '请选择内容',
                        clearable: true,
                    };
                }
                queryList.push(obj);
            }
            /* 查询 */
            if (item.isHidden) {
                /* 查询隐藏字段 */
                queryHiddenList[item.field] = item.defaultValue;
            }


            /* 列表 */
            if (item.isTable) {
                const obj = {
                    prop: item.alias,
                    label: item.comment,
                    f: item.component,
                };
                tableList.push(obj);
            }

            /* 编辑表单 */
            if (item.isWriteonly || item.isReadonly) {
                formList.push(item);
            }
            if (item.isWriteonly && item.enumType) {
                formEnum.push(item);
            }

        });
        console.log(tableList);
        const data = { fieldList, queryList, queryHiddenList, tableList, formList, formEnum };
        // 渲染模版
        const infovue = await ctx.renderView('generate/index.ejs', data);
        const editvue = await ctx.renderView('generate/edit.ejs', data);
        if (!fs.existsSync(filepath)) {
            fs.mkdirSync(filepath);
        }
        // 生成文件
        fs.writeFileSync(filepath + '/info.vue', infovue);
        fs.writeFileSync(filepath + '/edit.vue', editvue);
        ctx.body = {
            message: 'success',
        };
    }
}

module.exports = TableUtilsController;
