import Vue from 'vue';
import enumList from '@/store/modules/enumList';
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
            resolve(true);
        }).catch(() => {
            resolve(false);
        });
    });
};


/* 发送删除请求给后台 
 * url 请求地址
 * id 请求参数
*/
Vue.prototype.deleteRequestData = function (url, id, { message = '此操作将永久删除信息, 是否继续?' } = {}) {
    return new Promise((resolve) => {
        this.$confirm(message, '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'error'
        }).then(() => {
            let ids = id.join(',');
            this.$http.delete(`${url}/${ids}`).then(res => {
                resolve(res);
            }).catch(() => {
                resolve(false);
            });
        });
    });
}

/**
 * 全局删除执行方法
 * url      删除请求API
 * row      删除对象，对象内使用   ID   做为删除的判断依据
 * func     删除完成执行对象
 */
Vue.prototype.handleDelete = async function (url, row, func) {
    let ids = [];
    if (row.length > 0) {
        ids = row.map(item => item.id);
    } else {
        ids.push(row.id);
    }
    let message = await this.deleteRequestData(url, ids);
    if (message === false) {
        return
    }
    message.err > 0 ? this.$message.error(`删除失败条数：${message.err}`) : this.$message.success(`删除成功`);
    func();
};




/** 数据深拷贝 */
Vue.prototype.DeepCopy = function (obj) {
    var result = Array.isArray(obj) ? [] : {};
    for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
            if (typeof obj[key] === 'object' && obj[key] !== null) {
                result[key] = this.DeepCopy(obj[key]);   //递归复制
            } else {
                result[key] = obj[key];
            }
        }
    }
    return result;
}


/** 列表匹配字段 
 * key　　　枚举列表
 * value    匹配值
 */
Vue.prototype.ListMatchField = function (key, value) {
    const data = enumList.state.data[key];
    let str = '暂无信息';
    for (let i = 0; i < data.length; i++) {
        if (data[i].value == value) {
            str = data[i].title;
            break;
        }
    }
    return str;
}