const api = '/api'

const config = {
    sys: {
        login: `${api}/user/login`,
        dict: `${api}/sys/dict`
    },
    member: {
        info: `${api}/member`
    },
}
export default config;
export interface ApiInstance {
    sys: any,
    member: any
}


// const api = '/api'

// export class apiConfig {
//     get() {
//         return {
//             sys: {
//                 login: `${api}/user/login`,
//                 dict: `${api}/sys/dict`
//             },
//             member: {
//                 info: `${api}/member`
//             },
//         }
//     }

// }
