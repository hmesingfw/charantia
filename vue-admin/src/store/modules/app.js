import Cookies from 'js-cookie'

const app = {
    state: {
        sidebar: {
            opened: localStorage.getItem('sidebarStatus') == 'true' ? true : false,
            withoutAnimation: false
        },
        device: 'desktop',
        language: localStorage.getItem('language') || 'zh',
        size: Cookies.get('size') || 'medium'
    },
    mutations: {
        SET_LANGUAGE: (state, language) => {
            state.language = language
            localStorage.setItem('language', language);
            // Cookies.set('language', language)
        },
        TOGGLE_SIDEBAR: (state) => {
            state.sidebar.opened = !state.sidebar.opened;
            localStorage.setItem('sidebarStatus', state.sidebar.opened);
        }
    },
    actions: {
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
        }
    }
}

export default app;