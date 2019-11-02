import axios from 'axios'
import api from '@/config/api'


const state = {
    doctor: [],         // 医生职称
    patientsAge: [],    //病人年龄
    norms: [],           //显示规格
    type: [],            // 类型
    nurseType: [],            // 护士类型
    sectionOffice: [],      //科室

}

const mutations = {
    SET_VALUE: (state, data) => {

        data.forEach(obj => {
            if (obj.type == 1) {
                state.doctor = obj.optionValues;

            } else if (obj.type == 2) {
                state.sectionOffice = obj.optionValues;

            } else if (obj.type == 3) {
                state.patientsAge = obj.optionValues;

            } else if (obj.type == 4) {
                state.nurseType = obj.optionValues;

            } else if (obj.type == 5) {
                state.type = obj.optionValues;

            } else if (obj.type == 6) {
                state.norms = obj.optionValues;
            }

        });
    },
}

const actions = {
    // 用户名登录
    GetEnum({
        commit
    }) {
        axios.get(api.sys.options).then(res => {
            console.log(res);
            commit('SET_VALUE', res.data.data)
        })
    },
}

export default {
    namespaced: true,
    state,
    mutations,
    actions
}
