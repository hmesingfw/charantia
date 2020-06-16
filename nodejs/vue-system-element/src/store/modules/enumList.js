import axios from 'axios'
import api from '@/config/api'
const state = {
    data: {},
    static: {
        // 
        regType: [
            { title: '自主', value: 1 },
            { title: '平台', value: 2 }
        ],
        statusList: [
            { title: '启用', value: 0 },
            { title: '禁用', value: 1 }
        ],
        components: [
            { title: '输入框', value: 'el-input' },
            { title: '选择框', value: 'el-select' },
            { title: '单选框', value: 'el-radio' },
            { title: '日期选择器', value: 'el-date-picker' },
            { title: '开关选择器', value: 'el-switch' },
            { title: '计数器', value: 'el-input-number' },

        ],
    },
}

const mutations = {
    GET_ENUM: (state, data) => {
        state.data = { ...data, ...state.static };
    }
}

const actions = {
    /* 获取系统枚举值 */
    getEnum({
        commit
    }) {
        axios.get(api.sys.enum).then(res => {
            let data = {};
            res.data.rows.forEach(item => {
                data[item.value] = item.children
            });
            commit('GET_ENUM', data)
        });
    },
}

export default {
    namespaced: true,
    state,
    mutations,
    actions
}
