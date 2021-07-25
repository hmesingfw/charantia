import { ElMessage, ElMessageBox } from 'element-plus'
import { Code } from '@/config/index'
import HttpConfig from "@/config/axios-config";

export default class {
    url: string;  // 请求路径
    constructor(url: string) {
        this.url = url;
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
        }).then(() => {
            console.log(this.url)
            HttpConfig.delete(`${this.url}/${id}`).then((res: any) => {
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
    async Save(url: string, info: any) {
        const res: any = await HttpConfig.post(`${url}`, info);
        const { message, code } = res;

        ElMessage({
            message: message,
            type: code == Code.SUCCESS ? "success" : "info"
        });

    }
    Patch() { }

}
