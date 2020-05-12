'use strict';
const uuidv4 = require('uuid/v4');
const Controller = require('egg').Controller;

// node.js 文件操作对象
const fs = require('fs');
// node.js 路径操作对象
const path = require('path');
// 管道读入一个虫洞。
const sendToWormhole = require('stream-wormhole');
class FileController extends Controller {
    async index() {
        const ctx = this.ctx;
        const where = { ...ctx.query };
        ctx.body = await ctx.service.sys.file.list(where);
    }

    async create() {
        const ctx = this.ctx;
        const stream = await ctx.getFileStream(); // stream对象也包含了文件名，大小等基本信息

        const ext = stream.filename.substring(stream.filename.lastIndexOf('.'), stream.filename.length); // 文件后缀
        const filename = new Date().getTime() + ext;
        const filepath = `uploadfile/${filename}`;

        // 创建文件写入路径
        const target = path.join('./app/public/', filepath);

        await new Promise((resolve, reject) => {
            // 创建文件写入流
            const remoteFileStrem = fs.createWriteStream(target);
            // 以管道方式写入流
            stream.pipe(remoteFileStrem);

            let errFlag;
            // 监听error事件
            remoteFileStrem.on('error', err => {
                errFlag = true;
                // 停止写入
                sendToWormhole(stream);
                remoteFileStrem.destroy();
                console.log(err);
                reject(err);
            });

            // 监听写入完成事件
            remoteFileStrem.on('finish', () => {
                if (errFlag) return;
                resolve({ filename, name: stream.fields.name });
            });
        });

        let isImg = 0;
        const imgType = ['.jpg', '.png'];

        if (imgType.includes(ext)) {
            isImg = 1;
        }

        const obj = {
            id: uuidv4(),
            fileName: stream.filename,
            saveName: filename,
            savePath: filepath,
            ext, isImg,
            mime: stream.mime,
        };
        const body = await ctx.service.sys.file.create(obj);
        ctx.body = {
            message: '上传成功',
            id: body.id,
            url: filepath,
        };
    }

    async update() {
        const ctx = this.ctx;
        const stream = await ctx.getFileStream();
        ctx.body = {
            stream,
        };
    }
    async destroy() {
        const ctx = this.ctx;
        const id = ctx.params.id;

        ctx.body = await ctx.service.sys.file.del(id);
        ctx.status = 200;
    }

    async getFile() {
        const ctx = this.ctx;
        const id = ctx.query.id;
        const file = await ctx.service.sys.file.find(id);
        const target = path.join('./app/public/', file.savePath);
        ctx.body = fs.readFileSync(target);
        ctx.status = 200;
    }
}

module.exports = FileController;
