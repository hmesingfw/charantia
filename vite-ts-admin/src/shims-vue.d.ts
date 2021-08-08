declare module '*.vue' {
    import { DefineComponent } from 'vue'
    const component: DefineComponent<{}, {}, any>
    export default component
}


// import http from './utils/http'
// import Vue from 'vue'
// import { DeepCopy } from '@/utils/index'
// declare module 'vue/types/vue' {
//     // interface Vue {
//     //     $DeepCopy: Function,
//     // }

//     interface VueConstructor {
//         $DeepCopy: Function,
//         $http: http,
//     }

// }
