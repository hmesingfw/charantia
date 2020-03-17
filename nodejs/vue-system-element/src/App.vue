<template>
    <div id="app">
        <router-view />
    </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'
import { TogetherRouter } from '@/utils/sys';
export default {
    name: 'App',
    computed: {
        ...mapState({
            sqlRouter: state => state.permission.sqlRouter,
        }),
    },
    created() {
        this.initStore();
        this.initMenu();
        setTimeout(() => {

            this.init();
        }, 2000)
    },
    methods: {
        ...mapActions({
            initStore: 'enumList/getEnum',
            initMenu: 'permission/ADD_SQLROUTES'
        }),
        init() {
            let routerArr = [];
            routerArr = TogetherRouter(this.sqlRouter);
            routerArr.push({ path: '*', redirect: '/404', hidden: true }); /* 404 页面 */
            this.$router.addRoutes(routerArr);          /* 重新刷新routes内容信息 */

            this.$store.dispatch('permission/ADD_ROUTES', routerArr); /* 重新加载面板 */
        },
    }
}
</script>
