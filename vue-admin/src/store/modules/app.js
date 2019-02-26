import Cookies from 'js-cookie'

const app = {
    state: {
        sidebar: {
            opened: !+Cookies.get('sidebarStatus'),
            withoutAnimation: false
        },
        device: 'desktop',
        language: Cookies.get('language') || 'zh',
        size: Cookies.get('size') || 'medium'
    },
    mutations: {
        SET_LANGUAGE: (state, language) => {
            state.language = language
            Cookies.set('language', language)
        },
    },
    actions: {
        setLanguage({
            commit
        }, language) {
            commit('SET_LANGUAGE', language)
        },
    }
}

export default app;