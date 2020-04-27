'use strict';
const moment = require('moment');
const JWT = require('jsonwebtoken');
module.exports = {
    /* 字符串转数字 */
    parseInt(string) {
        if (typeof string === 'number') return string;
        if (!string) return string;
        return parseInt(string) || 0;
    },
    /* 查询默认条件 */
    whereParams: {
        isDel: '0',
    },

    /* 为对象更新    更新时间和操作人员 */
    updateTime(obj) {
        obj.updatedAt = moment(new Date()).format('YYYY-MM-DD HH:mm:ss');
        return obj;
    },

    userId() {
        let obj;
        try {
            // 验证当前token
            obj = JWT.verify(this.ctx.request.header.authorization, this.config.jwt.secret);
        } catch (err) {
            console.log(err);
        }
        return obj && obj.id;
    },
};
