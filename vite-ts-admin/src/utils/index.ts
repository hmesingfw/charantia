import { ElMessage, ElMessageBox } from 'element-plus'
import { Code } from '@/config/index'
import HttpConfig from "@/config/axios-config";
import Http from "./http";

interface Response {
    code: number,
    data: any,
    message: string,
}

/**
 * 请求删除通用方法ElMessage 
 * @param {string} url 请求地址
 * @param {number} id 删除值
 * @param {function} query 回调方法
 */
export function HttpDel(url: string, id: number, query: any) {
    ElMessageBox.confirm('此操作将永久删除该文件, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
    }).then(() => {
        HttpConfig.delete(`${url}/${id}`).then((res: any) => {
            const { message, code } = res;
            ElMessage({
                message: message,
                type: code == Code.SUCCESS ? "success" : "info"
            });
            query();
        });
    }).catch(() => {
        ElMessage({
            message: '已取消',
            type: "info"
        });
    })
}

/**
 * 请求保存方法体
 * @param url 请求地址
 * @param info 请求体
 * @param query 回调方法
 */
export function HttpSave(url: string, info: any) {
    return new Promise(async (resolve: any, reject: any) => {
        let res: Response;
        if ('id' in info) {
            res = await HttpConfig.patch(`${url}/${info.id}`, info);
        } else {
            res = await HttpConfig.post(`${url}`, info);
        }
        ElMessage({
            message: res.message,
            type: res.code == Code.SUCCESS ? "success" : "info"
        });
        resolve(res)
    })
}


/** 
 * 数据深拷贝 
 * @param {Object/Array} obj 复制值
 *
 * */
export function DeepCopy(obj: any) {
    var result: any = Array.isArray(obj) ? [] : {};
    for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
            if (typeof obj[key] === 'object' && obj[key] !== null) {
                result[key] = DeepCopy(obj[key]); // 递归复制
            } else {
                result[key] = obj[key];
            }
        }
    }
    return result;
}


export default (app: any) => {
    app.config.globalProperties.$Http = Http;
    app.config.globalProperties.$HttpDel = HttpDel;
    app.config.globalProperties.$HttpSave = HttpSave;
    app.config.globalProperties.$DeepCopy = DeepCopy;
}