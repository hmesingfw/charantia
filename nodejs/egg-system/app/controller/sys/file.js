'use strict';
// const uuidv4 = require('uuid/v4');
const Controller = require('egg').Controller;

class FileController extends Controller {
    async index() {
        const ctx = this.ctx;
        const where = { ...ctx.query };
        ctx.body = await ctx.service.sys.file.list(where);
    }

    async create() {
        const ctx = this.ctx;
        const stream = await ctx.getFileStream();
        console.log(stream);

        ctx.body = {
            stream,
        };
    }

    async update() {
        const ctx = this.ctx;
        const stream = await ctx.getFileStream();
        console.log(stream);

        ctx.body = {
            stream,
        };
    }
    async destroy() {
        const ctx = this.ctx;
        const id = ctx.params.id;

        ctx.body = await ctx.service.sys.enum.del(id);
        ctx.status = 200;
    }
}

module.exports = FileController;
