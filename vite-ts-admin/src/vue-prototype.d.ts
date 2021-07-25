import http from './utils/http'
import { DeepCopy } from './utils/index'
declare module 'vue/types/vue' {
    interface VueConstructor {
        $DeepCopy: DeepCopy,
        $http: http,
    }
}