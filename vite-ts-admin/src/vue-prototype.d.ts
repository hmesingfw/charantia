import { CodeInterface } from '@/config/index';
import { ApiInstance } from "./config/api";
import http from './utils/http'
import { IMessage } from 'element-plus/lib/el-message/src/types';
import { ActionContext } from 'vuex';




// 对vue进行类型补充说明
declare module '@vue/runtime-core' {
    interface ComponentCustomProperties {
        $DeepCopy: Function,
        $api: ApiInstance,
        $http: http,
        $refs: any,
        $code: CodeInterface
        $message: IMessage,
        $store: ActionContext<any, any>
    }
}

