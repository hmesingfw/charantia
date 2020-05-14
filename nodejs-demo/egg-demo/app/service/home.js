'use strict';

const Service = require('egg').Service;
const axios = require('axios');
class Home extends Service {

    async getAccessToken() {
        return axios.get('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx4041c8c50c6406d9&secret=APPSECRET');
    }
}

module.exports = Home;
