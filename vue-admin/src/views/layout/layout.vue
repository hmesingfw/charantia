<template>
    <div>
        <sidebar></sidebar>
        <div class="main-container">
            <navbar></navbar>
        </div>
    </div>
</template>

<script>
import Sidebar from './components/Sidebar/index.vue';
import navbar from './components/navbar.vue'
export default {
    name: 'layout',
    components: {
        Sidebar,
        navbar
    }
}
</script>

<style lang="less" scoped>
.main-container {
    min-height: 100%;
    -webkit-transition: margin-left 0.28s;
    transition: margin-left 0.28s;
    margin-left: 180px;
    position: relative;

}
</style>
