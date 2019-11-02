import { Loading } from "element-ui";
export function GetHeight(offset) {
    return document.documentElement.clientHeight - offset + 'px';
}


/** 数据深拷贝 */
export function DeepCopy(obj) {
    var result = Array.isArray(obj) ? [] : {};
    for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
            if (typeof obj[key] === 'object' && obj[key] !== null) {
                result[key] = DeepCopy(obj[key]);   //递归复制
            } else {
                result[key] = obj[key];
            }
        }
    }
    return result;
}

/* 异常错误提示 */
export function ErrorLog(err) {
    console.log(err)
}


/* 获取用户会话ID */
export function GetId() {
    return localStorage.getItem('userId');
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

// 数据加载弹窗
let loading
export function starLoading() {
    loading = Loading.service({
        lock: true,
        text: '数据加载中...',
        background: 'rgba(0, 0, 0, 0.1)'
    })
}
// 关闭数据加载弹窗
export function closeLoading() {
    loading.close();
}

// 函数节流
export function bonseFunc(func, time = 1000) {
    if (timeout) clearTimeout(timeout)
    let timeout = setTimeout(() => {
        func
    }, time)
}
export function formatDate(now) {
    var year = now.getFullYear()
    var month = (now.getMonth() + 1) < 10 ? '0' + (now.getMonth() + 1) : now.getMonth() + 1
    var date = (now.getDate() < 10 ? '0' + now.getDate() : now.getDate())
    return year + "-" + month + "-" + date
}
export function dateTitle(now) {
    var year = now.getFullYear()
    var month = (now.getMonth() + 1) < 10 ? '0' + (now.getMonth() + 1) : now.getMonth() + 1
    var date = (now.getDate() < 10 ? '0' + now.getDate() : now.getDate())
    var after = now.getHours() > 12 ? '下午好！' : now.getHours() > 18 ? "晚上好！" : "早上好！"
    return year + "年" + month + "月" + date + "日" + "，" + after
}
export function formTime(now) {
    var hour = now.getHours() < 10 ? 0 + now.getHours() : now.getHours()
    var minute = now.getMinutes() < 10 ? '0' + now.getMinutes() : now.getMinutes()
    var second = now.getSeconds() < 10 ? '0' + now.getSeconds() : now.getSeconds()
    return hour + ":" + minute + ":" + second
}




Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
}



// 标识登录身份
var markIdentity = '';
export function setMarkIdentity(identity) {
    markIdentity = identity;
}
export function getMarkIdentity() {
    return markIdentity;
}




/* 发送删除请求给后台 */
export function deleteRequestData(url, id, message = '此操作将永久删除信息, 是否继续?') {
    return new Promise((resolve) => {

        console.log(url);
        this.$confirm(message, "提示", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "error"
        }).then(() => {
            this.$http.delete(url, { data: id }).then(res => {
                if (res.data.code == 200) {
                    this.$message.success(res.data.message);
                    resolve(true)
                } else {
                    this.$message.info(res.data.message);
                    resolve(false)
                }
            }).catch(err => {
                resolve(false)
                ErrorLog(err);
            });
        })
    })
}