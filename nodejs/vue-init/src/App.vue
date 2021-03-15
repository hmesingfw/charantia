<template>
    <div id="app">
        <router-view />
    </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'
import { TogetherRouterIndex } from '@/utils/sys';
export default {
    name: 'App',
    computed: {
        ...mapState({
            sqlRouterIndex: state => state.permission.sqlRouterIndex,
        }),
    },
    created() {
        this.init();
        this.initStore();
    },
    methods: {
        ...mapActions({
            initStore: 'enumList/getEnum',
        }),
        init() {
            let routerArr = [];
            routerArr = TogetherRouterIndex(this.sqlRouterIndex);
            routerArr.push({ path: '*', redirect: '/404', hidden: true }); /* 404 页面 */
            this.$router.addRoutes(routerArr);          /* 重新刷新routes内容信息 */

            this.$store.dispatch('permission/ADD_ROUTES_INDEX', routerArr); /* 重新加载面板 */

            // let token = this.token;
            // if (!token || token == 'undefined') {
            //     this.$router.push({ path: '/login' });
            // }
        },
    }
}
</script>
