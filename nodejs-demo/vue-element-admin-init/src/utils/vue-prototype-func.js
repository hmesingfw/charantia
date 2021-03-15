import Vue from 'vue';
import store from '@/store/index';
import { SUCCESS } from '@/utils/res-code'

Vue.prototype.formatTime = function (time, formatValue = 'yyyy-MM-dd hh:mm:ss') {
    if (!time || time == 0 || time === '0') return '';
    let str = '';
    try {
        const data = new Date();
        data.setTime(time);

        str = data.Format(formatValue);
    } catch (error) {
        str = '';
    }
    return str;
}
/**
 * 封装请求
 * url 请求地址
 * form 请求内容
 * reqType 请求类型
 */
Vue.prototype.ReqData = function (url, form, reqType, { idKey = 'id', msg = true } = {}) {
    return new Promise((resolve) => {
        const put = reqType == 'put' ? '/' + form[idKey] : '';

        this.$http[reqType](`${url}${put}`, form).then(res => {
            if (msg) {
                const msgType = res.data.code == SUCCESS ? 'success' : 'info';
                this.$message[msgType](res.data.message);
            } else {
                resolve(res);
            }

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
Vue.prototype.DeleteRequestData = function (url, id, { message = '此操作将永久删除信息, 是否继续?' } = {}) {
    return new Promise((resolve, reject) => {
        this.$confirm(message, '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'error'
        }).then(() => {
            const ids = id.join(',');
            // , { data: id }
            this.$http.delete(`${url}/${ids}`).then(res => {
                resolve(res);
            }).catch(() => {
                reject(false);
            });
        });
    });
}

/* 列表更新字段方法 */
/*
*   data   数据
*   url    请求地址
*   keys   更改数据key值
*/
Vue.prototype.UpdateField = async function (data, url, keys, func, { reqType = 'put', idKey = 'id' } = {}) {
    const form = {};
    form[idKey] = data[idKey];
    if (keys instanceof Array) {
        keys.forEach(k => {
            form[k] = data[k];
        })
    } else {
        form[keys] = data[keys];
    }
    const put = reqType == 'put' ? '/' + data[idKey] : '';
    const result = await this.$http[reqType](`${url}${put}`, form);

    this.$message.success(result.data.message);
    func();
}

Vue.prototype.UpdateSwitch = async function (data, url, key, func, { reqType = 'put', idKey = 'id' } = {}) {
    const form = {};
    form[idKey] = data[idKey];
    form[key] = data[key];
    const put = reqType == 'put' ? '/' + data[idKey] : '';
    // let put = '';
    const result = await this.$http[reqType](`${url}${put}`, form);
    const msgType = result.data.code == SUCCESS ? 'success' : 'info';
    this.$message[msgType](result.data.message);
    func();
}

/**
 * 全局删除执行方法
 * url      删除请求API
 * row      删除对象，对象内使用   ID   做为删除的判断依据
 * func     删除完成执行对象
 */
Vue.prototype.HandleDelete = async function (url, row, func, { idKey = 'id' } = {}) {
    let ids = [];
    if (row.length > 0) {
        ids = row.map(item => item[idKey]);
    } else {
        ids.push(row[idKey]);
    }
    const res = await this.DeleteRequestData(url, ids);
    if (res.data.code !== SUCCESS) {
        this.$message.info(res.data.message)
    } else {
        this.$message.success(res.data.message)
    }
    func();
};

/** 数据深拷贝 */
Vue.prototype.DeepCopy = function (obj) {
    var result = Array.isArray(obj) ? [] : {};
    for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
            if (typeof obj[key] === 'object' && obj[key] !== null) {
                result[key] = this.DeepCopy(obj[key]); // 递归复制
            } else {
                result[key] = obj[key];
            }
        }
    }
    return result;
}

/** 列表匹配字段
 * key      枚举列表
 * value    匹配值
 */
Vue.prototype.ListMatchField = function (key, value) {
    if (!store.getters.enumList[key]) return '';
    const data = store.getters.enumList[key];

    let str = '';
    for (let i = 0; i < data.length; i++) {
        if (data[i].value == value) {
            str = data[i].title;
            break;
        }
    }
    return str;
}
Vue.prototype.ForFindValue = function (list, key, value, rekey, option = { returnStr: '' }) {
    const re = option.returnStr;
    for (let i = 0; i < list.length; i++) {
        const data = list[i];
        if (data[key] == value) {
            return data[rekey];
        }
    }
    return re;
}

Vue.prototype.roundFun = function (numberRound, roundDigit) {
    if (numberRound == 0) {
        return '0.00';
    }
    // 四舍五入，保留位数为roundDigit
    if (numberRound > 0) {
        return numberRound.toFixed(2);
    }
}
/* 判断文件是否有blob */
Vue.prototype.ImgIsBlob = function (url) {
    return url.indexOf('blob:') == -1
}

Vue.prototype.ConfigParmas = {
    switchValue: {
        'active-value': 1,
        'active-text': '启用',
        'inactive-value': 0,
        'inactive-text': '禁用',
        'active-color': '#4fc08d',
    },
    switchValue2: {
        'active-value': 1,
        'active-text': '是',
        'inactive-value': 0,
        'inactive-text': '否',
        'active-color': '#4fc08d',
    },
    statusListIsOpen: {
        'active-value': 1,
        'active-text': '开放',
        'inactive-value': 0,
        'inactive-text': '关闭',
        'active-color': '#4fc08d',
    },
    pagination: {
        page: 1,
        limit: localStorage.getItem('pageSize') || 10,
    },
    imageError: require('@/assets/image-error.png'),
    // imageError: 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
}
Vue.prototype.getRanderColor = function (value) {
    const colorArr = [
        // '#E6A23C', '#67C23A', '#F56C6C', '#FFFFFF', '#FCFCFC'
        '#409EFF', // 主色   蓝色
        '#67C23A', // Success   绿色
        '#E6A23C', // Warning   黄色
        '#F56C6C', // Danger    红色
        'rgb(0, 180, 255, .7)', // 主色   蓝色 .5
        'rgb(255, 0, 0, .5)', // 红色 .5
        '#9C27B0',
    ]

    const intKey = (parseInt(value) + 1) % colorArr.length;

    return colorArr[intKey]
}

Vue.prototype.GetServerColor = function (key) {
    const colorArr = {
        '-1': '#E6A23C',
        '70': '#67C23A',
        '80': 'rgb(0, 180, 255, .7)',
        '90': '#409EFF',
        '99': 'rgb(255, 0, 0, .5)',
        '250': '#9C27B0',
    }

    return colorArr[key] || '';
}
