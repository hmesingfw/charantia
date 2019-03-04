<template>
    <div>
        <hamburger
            :is-active="sidebar.opened"
            :toggle-click="toggleSideBar"
            class="hamburger-container"
        />
    </div>
</template>

<script>
// :toggle-click="toggleSideBar"
import hamburger from '@/components/Hamburger/index.vue'
import { mapState } from 'vuex'
export default {

    name: 'navbar',
    data () {
        return {
            isCollapse: true,
            // sidebar: {
            //     opened: true
            // }
        };
    },
    components: {
        hamburger
    },
    computed: mapState({
        sidebar: state => state.app.sidebar
    }),
    methods: {
        toggleSideBar () {
            this.$store.dispatch('toggleSideBar')
        },
    },
}
</script>
<style lang="less" scoped>
</style>

