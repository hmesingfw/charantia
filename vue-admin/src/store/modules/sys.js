import axios from 'axios';
const sys = {
    state: {
        componentTypeList: [], // 组件列表
        validateList: [], // 验证数据列表
    },
    mutations: {
        FLASHENUMLIST(state) {
            axios.post('/egg/getAllEnum').then(res => {
                res.data.data.forEach(data => {

                    // 组件列表
                    if (data.type == 'componentType') {
                        state.componentTypeList.push(data);
                    }

                    // 验证数据列表
                    if (data.type == 'validate') {
                        state.validateList.push(data);
                    }
                });
            })
        }
    },
    actions: {
        flashEnumList({
            commit
        }) {
            commit('FLASHENUMLIST')
        }
    }
}

export default sys;