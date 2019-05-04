'use strict';

const Controller = require('egg').Controller;
const jwt = require('jsonwebtoken');

const fs = require('fs');

const privateKey = fs.readFileSync('./config/private.key');
const pulicKey = fs.readFileSync('./config/public.key');

class HomeController extends Controller {
	async login() {
		const {
			ctx,
		} = this;

		// Token 数据
		const payload = {
			name: 'wanghao',
			admin: true,
		};

		// 密钥
		// const secret = 'woshizhangsan';

		// 签发 Token
		const tokenRS256 = jwt.sign(payload, privateKey, {
			algorithm: 'RS256',
		});

		// 输出签发的 Token
		// console.log(tokenRS256);

		ctx.body = {
			data: 'hi, login',
			token: tokenRS256,
		};
	}

	async user() {
		const {
			ctx,
		} = this;

		// const header = ctx.header;
		const token = ctx.get('token');
		console.log(token);

		// 验证 Token
		jwt.verify(token, pulicKey, (error, decoded) => {
			if (error) {
				console.log(error.message);
				// return false;
			}
			console.log(decoded);
		});
		ctx.body = {
			data: 'heiij',
		};
	}
}

module.exports = HomeController;

