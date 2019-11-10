

const state = {
    enumval: {
        doctor: 21,         // 医生职称
        nurseType: 22,            // 护士类型
        patientsAge: [],    //病人年龄
        type: [],            // 类型
        sectionOffice: [],      //科室
        norms: {
            name: 19,               // 病床
            title: 18,              //  病床加姓名
            nameTitle: 20,           // 姓名
        },           //显示规格

    }
}

const mutations = {

}

const actions = {

}

export default {
    namespaced: true,
    state,
    mutations,
    actions
}
