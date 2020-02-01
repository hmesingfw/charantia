'use strict';

module.exports = {
    /* 字符串转数字 */
    parseInt(string) {
        if (typeof string === 'number') return string;
        if (!string) return string;
        return parseInt(string) || 0;
    },
};
