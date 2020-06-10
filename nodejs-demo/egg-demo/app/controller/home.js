'use strict';
const axios = require('axios');
const Controller = require('egg').Controller;

class HomeController extends Controller {
    async index() {
        const { ctx } = this;
        ctx.body = await ctx.renderView('index.ejs', { data: 'hello world' });
    }

    async newvide() {
        const { ctx } = this;
        ctx.body = await ctx.renderView('src/new.ejs');
    }

    async dofeng() {
        const { ctx } = this;
        ctx.body = await ctx.renderView('src/dofeng.ejs');
    }

    async getCode() {
        const { ctx } = this;
        // const message = await axios.post('https://api.weixin.qq.com/cgi-bin/qrcode/create', {
        //     access_token: '',
        //     expire_seconds: 6000,
        //     action_name: 'QR_SCENE',
        //     scene_id: 778,
        //     scene_str: 'node',
        // });
        const message = await ctx.service.home.getAccessToken();
        const code = await ctx.service.home.createCode(message.access_token);
        // const url = await ctx.service.home.getTicket(code.body.ticket);
        console.log(code.body);
        ctx.body = {
            message, code,
            // url,
        };
    }


}

module.exports = HomeController;
