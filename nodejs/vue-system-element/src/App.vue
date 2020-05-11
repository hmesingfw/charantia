<template>
    <div id="app">
        <router-view />
    </div>
</template>

<script>
import { mapState } from 'vuex'
import { TogetherRouter } from '@/utils/sys';
export default {
    name: 'App',
    computed: {
        ...mapState({
            sqlRouter: state => state.permission.sqlRouter,
        }),
    },
    created() {
        this.init();
    },
    methods: {
        init() {
            let routerArr = [];
            routerArr = TogetherRouter(this.sqlRouter);
            routerArr.push({ path: '*', redirect: '/404', hidden: true }); /* 404 页面 */
            this.$router.addRoutes(routerArr);          /* 重新刷新routes内容信息 */

            this.$store.dispatch('permission/ADD_ROUTES', routerArr); /* 重新加载面板 */

            // let token = this.token;
            // if (!token || token == 'undefined') {
            //     this.$router.push({ path: '/login' });
            // }
        },
    }
}
</script>
