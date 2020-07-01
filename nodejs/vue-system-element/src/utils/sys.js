import axios from 'axios';
import api from '@/config/api';
import { Message } from 'element-ui';

export function GetHeight(offset) {
    return document.documentElement.clientHeight - offset + 'px';
}

/* 异常错误提示 */
export function ErrorLog(err) {
    // eslint-disable-next-line no-console
    console.log(err);
}




export function FileBeforeAvatarUpload(file) {
    const isJPG = file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/gif' || file.type === 'image/bmp';
    const isLt2M = file.size / 1024 < 200;
    if (!isJPG) {
        this.$message.error('上传头像图片只能是jpg,png,gif,bmp格式!');
        return false;
    }
    if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 200KB!');
        return false;
    }
    return isLt2M && isJPG;
}
export function formatDate(now) {
    var year = now.getFullYear();
    var month = (now.getMonth() + 1) < 10 ? '0' + (now.getMonth() + 1) : now.getMonth() + 1;
    var date = (now.getDate() < 10 ? '0' + now.getDate() : now.getDate());
    return year + '-' + month + '-' + date;
}
export function dateTitle(now) {
    var year = now.getFullYear();
    var month = (now.getMonth() + 1) < 10 ? '0' + (now.getMonth() + 1) : now.getMonth() + 1;
    var date = (now.getDate() < 10 ? '0' + now.getDate() : now.getDate());
    var after = now.getHours() > 12 ? '下午好！' : now.getHours() > 18 ? '晚上好！' : '早上好！';
    return year + '年' + month + '月' + date + '日' + '，' + after;
}
export function formTime(now) {
    var hour = now.getHours() < 10 ? 0 + now.getHours() : now.getHours();
    var minute = now.getMinutes() < 10 ? '0' + now.getMinutes() : now.getMinutes();
    var second = now.getSeconds() < 10 ? '0' + now.getSeconds() : now.getSeconds();
    return hour + ':' + minute + ':' + second;
}




Date.prototype.Format = function (fmt) {
    var o = {
        'M+': this.getMonth() + 1, //月份 
        'd+': this.getDate(), //日 
        'h+': this.getHours(), //小时 
        'm+': this.getMinutes(), //分 
        's+': this.getSeconds(), //秒 
        'q+': Math.floor((this.getMonth() + 3) / 3), //季度 
        'S': this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    for (var k in o) {
        if (new RegExp('(' + k + ')').test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (('00' + o[k]).substr(('' + o[k]).length)));
        }
    }
    return fmt;
};



// 标识登录身份
var markIdentity = '';
export function setMarkIdentity(identity) {
    markIdentity = identity;
}
export function getMarkIdentity() {
    return markIdentity;
}

/* 封装post 请求 */
/* 
*   url  请求路很
*   form 数据
*   请求类型
*   option{
*       isAlert 加载弹框
*       isResult 返回res
*   }
*/
export function ReqData(url, form, reqType, { isAlert = true, isResult = false } = {}) {
    return new Promise((resolve) => {

        this.$http[reqType](url, form).then(res => {
            if (res.data.code == 200) {
                isAlert && this.$message.success(res.data.message);
                resolve(isResult === false ? true : res);
            } else {
                isAlert && this.$message.info(res.data.message);
                resolve(isResult === false ? false : res);

            }
        }).catch(err => {
            resolve(false);
            ErrorLog(err);
        });
    });

}


/* 封装请求  切换状态按钮 */
/* 
*   url  请求路很
*   form 数据
*   请求类型
*   option{
*       isAlert 加载弹框
*       isResult 返回res
*   }
*/
export function reqChangeStatus(url, form, reqType,
    { isAlert = true, alertMessage = { suc: '保存修改成功', err: '保存修改失败' }, isResult = false } = {}) {
    return new Promise((resolve) => {
        axios[reqType](url, form).then(res => {
            if (res.data.code == 200) {
                isAlert ? Message.success(res.data.message) : Message.success(alertMessage.suc);
                resolve(isResult === false ? true : res);
            } else {
                isAlert ? Message.info(res.data.message) : Message.success(alertMessage.err);
                resolve(isResult === false ? false : res);

            }
        }).catch(() => {
            resolve(false);
        });

    });
}



/* 字符串截取 */
export function subst(str, num) {
    if (str && str.length > num) {
        return str.substring(0, num);
    } else {
        return str;
    }
}
/* list列表 查找指定数据 */
/* 
*   list 列表
*   key 判断key
*   value 判断值
*   rekey 返回key
*   option
*/
export function forFindValue(list, key, value, rekey, option = { returnStr: '' }) {
    let re = option.returnStr;
    for (let i = 0; i < list.length; i++) {
        let data = list[i];
        if (data[key] == value) {
            re = data[rekey];
        }
    }
    return re;
}



/* 组装路由表,将后台请求到的数据，组装成vue-ruter实别的格式信息 */
/* arr 接收数据 */
/* array 返回处理后的数据  */
export function TogetherRouter(arr) {
    let array = [];

    arr.forEach(item => {
        let json = {
            path: item.path,
            name: item.path + item.id,
            hidden: item.isHidden == 0,
            component: () => item.component == 'Layout' ? import('@/layout') : import(`@/admin/views${item.component}`),
            meta: { title: item.title, icon: item.icon },
        };
        if (item.children && item.children.length > 0) {
            json.children = TogetherRouter(item.children);
        }
        array.push(json);
    });

    return array;
}
export function TogetherRouterIndex(arr) {
    let array = [];

    arr.forEach(item => {
        let json = {
            path: item.path,
            name: item.path + item.id,
            hidden: item.isHidden == 0,
            component: () => item.component == 'Layout' ? import('@/layout') : import(`@index/views${item.component}`),
            meta: { title: item.title, icon: item.icon },
        };
        if (item.children && item.children.length > 0) {
            json.children = TogetherRouterIndex(item.children);
        }
        array.push(json);
    });
    return array;
}

/* 组装完成后的vue-router信息，过滤重复的数据 */
/* arr 接收数据 */
/* array 返回处理后的数据  */
export function FilterRepeatRouter(arr) {
    if (arr.length > 1) {
        let consult = arr[0];

        for (let i = 1; i < arr.length; i++) {
            Repeat(consult, arr[i]);
        }

        return consult;
    } else {
        return arr.length > 0 ? arr[0] : arr;
    }
}
/* 是否存在相同的地址 */
function Repeat(consult, arr) {

    arr.forEach(be => {
        let bePath = be.path;
        let stic = false;
        let beI = 0;

        for (let i = 0; i < consult.length; i++) {
            let cs = consult[i];
            if (cs.path == bePath) {
                stic = true;
                beI = i;
                break;
            }
        }
        /* 判断是否存在同样的path 路径 */
        if (!stic) {
            consult.push(be);   //不存在，添加
        } else {
            if (be && be.children) {
                Repeat(consult[beI].children, be.children);        // 存在，其子节点在做判断 
            }
        }
    });

}

export var ueConfig = {
    // 编辑器不自动被内容撑高
    autoHeightEnabled: false,
    // 初始容器高度
    initialFrameHeight: 400,
    // 初始容器宽度
    initialFrameWidth: '100%',
    // 上传文件接口（这个地址是我为了方便各位体验文件上传功能搭建的临时接口，请勿在生产环境使用！！！）
    serverUrl: api.sys.ueditor,
    // serverUrl: api.sys2.uditor,
    // UEditor 资源文件的存放路径，如果你使用的是 vue-cli 生成的项目，通常不需要设置该选项，vue-ueditor-wrap 会自动处理常见的情况，如果需要特殊配置，参考下方的常见问题2
    UEDITOR_HOME_URL: '/UEditor/',
    maximumWords: 1000,
};

/* 纯文本 */
export var ueConfigText = {
    // 编辑器不自动被内容撑高
    autoHeightEnabled: false,
    // 初始容器高度
    initialFrameHeight: 400,
    // 初始容器宽度
    initialFrameWidth: '100%',
    // 上传文件接口（这个地址是我为了方便各位体验文件上传功能搭建的临时接口，请勿在生产环境使用！！！）
    serverUrl: api.sys.ueditor,
    // serverUrl: api.sys2.uditor,
    // UEditor 资源文件的存放路径，如果你使用的是 vue-cli 生成的项目，通常不需要设置该选项，vue-ueditor-wrap 会自动处理常见的情况，如果需要特殊配置，参考下方的常见问题2
    UEDITOR_HOME_URL: '/UEditor/',
    maximumWords: 1000,
    toolbars: [[
        'fullscreen', 'source', '|', 'undo', 'redo', '|',
        'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'removeformat', 'formatmatch', 'autotypeset', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|',
        'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
        'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
        'indent', '|',
        'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify',
    ]]
};