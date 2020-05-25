'use strict';

const Service = require('egg').Service;
const https = require('https');
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
}

module.exports = Home;
