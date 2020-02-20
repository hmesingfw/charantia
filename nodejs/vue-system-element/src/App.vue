<template>
    <div id="app">
        <router-view />
    </div>
</template>

<script>
import { mapActions } from 'vuex'
export default {
    name: 'App',
    created() {
        this.initStore();
    },
    methods: {
        ...mapActions({
            initStore: 'enumList/getEnum'
        })
    }
}
</script>
