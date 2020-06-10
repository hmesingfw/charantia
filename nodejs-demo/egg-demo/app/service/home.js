'use strict';

const Service = require('egg').Service;
const https = require('https');
const http = require('http');
const superagent = require('superagent');

class Home extends Service {

    async getAccessToken() {
        return new Promise((resolve, reject) => {
            https.get('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx4041c8c50c6406d9&secret=65594ba76b1c5316ce4875fd29a818fc', function (res) {
                const chunks = [];
                res.on('data', function (chunk) {
                    chunks.push(chunk);
                });
                res.on('end', function () {
                    console.log(Buffer.concat(chunks).toString());
                    const str = JSON.parse(Buffer.concat(chunks));
                    resolve(str);
                });
            });
        });
        // return https.get('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx4041c8c50c6406d9&secret=65594ba76b1c5316ce4875fd29a818fc');
    }

    async createCode(token) {
        return new Promise((resolve, reject) => {
            superagent.post('https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=' + token).send(
                { action_name: 'QR_LIMIT_SCENE', action_info: { scene: { scene_str: 'http://www.hemin.shop/new' } } }
            ).end(function (err, res) {
                console.log(err);
                if (err) {
                    reject(err);
                } else {
                    resolve(res);
                }
            });
        });
        // return https.get('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx4041c8c50c6406d9&secret=65594ba76b1c5316ce4875fd29a818fc');
    }

    async getTicket(ticket) {
        return new Promise((resolve, reject) => {
            superagent.get('https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=' + ticket).end((err, res) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(res);
                }
            });
        });
    }

}

module.exports = Home;
