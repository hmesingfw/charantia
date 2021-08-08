import { ElMessage, ElMessageBox } from 'element-plus'
import { Code } from '@/config/index'
import HttpConfig from "@/config/axios-config";
import { AxiosResponse } from "axios";

export interface responseInterface {
    message: string,
    code: number,
    data: any
}
export default class {
    url?: string;  // 请求路径
    constructor(url: string) {
        this.url = url;
    }

    /**
     * SAVE 请求，转发分成POST 与PATCH 请求
     * @param url 请求体
     * @param info 请求对象
     */
    async Save(url: string, info: any) {
        if ("id" in info) {
            this.Patch(url, info)
        } else {
            this.Post(url, info)
        }
    }
    /**
     * POST 请求
     * @param url 请求地址
     * @param info 请求体
     */
    async Post(url: string, info: any) {
        const res: responseInterface = await HttpConfig.post(`${url}`, info);
        const { message, code } = res;

        ElMessage({
            message: message,
            type: code == Code.SUCCESS ? "success" : "info"
        });

    }
    /**
     * PATCH 请求类型
     * @param url 请求地址
     * @param info 请求对象
     */
    async Patch(url: string, info: any) {
        const res: responseInterface = await HttpConfig.patch(`${url}/${info.id}`, info);
        const { message, code } = res;

        ElMessage({
            message: message,
            type: code == Code.SUCCESS ? "success" : "info"
        });
    }

    /**
        * 请求删除通用方法ElMessage
        * @param {string} url 请求地址
        * @param {number} id 删除值
        * @param {function} query 回调方法
        */
    Del(id: string, query: any) {
        ElMessageBox.confirm('此操作将永久删除该文件, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(async () => {
            const res: responseInterface = await HttpConfig.delete(`${this.url}/${id}`)
            const { message, code } = res;
            ElMessage({
                message: message,
                type: code == Code.SUCCESS ? "success" : "info"
            });
            query();

        }).catch(() => {
            ElMessage({
                message: '已取消',
                type: "info"
            });
        })
    }

    /**
     * GET 请求
     * @param params 请求体
     * @returns promise
     */
    Get(params: any) {
        return HttpConfig.get(`${this.url}`, { params: params });
    }


}
