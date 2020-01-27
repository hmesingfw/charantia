import Vue from 'vue';
/**
 * 封装请求
 * url 请求地址
 * form 请求内容
 * reqType 请求类型
 */
Vue.prototype.reqData = function (url, form, reqType, { idKey = 'id' } = {}) {
    return new Promise((resolve) => {
        let put = reqType == 'put' ? '/' + form[idKey] : '';

        this.$http[reqType](`${url}${put}`, form).then(res => {
            if (res.data.code == 200) {
                this.$message.success(res.data.message);
                resolve(true);
            } else {
                resolve(false);
            }
        }).catch(() => {
            resolve(false);
        });
    });
};