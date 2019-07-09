
const state = {
    sidebar: {
        opened: localStorage.getItem('sidebarStatus') == 'true' ? true : false,
        withoutAnimation: false
    },
    device: 'desktop',
    language: localStorage.getItem('language') || 'zh',
    size: localStorage.getItem('size') || 'small'
};
const mutations = {
    SET_LANGUAGE: (state, language) => {
        state.language = language
        localStorage.setItem('language', language);
        // Cookies.set('language', language)
    },
    TOGGLE_SIDEBAR: (state) => {
        state.sidebar.opened = !state.sidebar.opened;
        localStorage.setItem('sidebarStatus', state.sidebar.opened);


    },

    SET_SIZE: (state, size) => {
        state.size = size
        localStorage.setItem('size', size)
    },
    TOGGLE_DEVICE: (state, device) => {
        state.device = device
    },
};
const actions = {
    setLanguage({
        commit
    }, language) {
        commit('SET_LANGUAGE', language)
    },
    /** 菜单申缩 */
    toggleSideBar({
        commit
    }) {
        commit('TOGGLE_SIDEBAR')
    },
    setSize({
        commit
    }, size) {
        commit('SET_SIZE', size)
    },
    toggleDevice({ commit }, device) {
        commit('TOGGLE_DEVICE', device)
    },
}


export default {
    namespaced: true,
    state, mutations, actions
};