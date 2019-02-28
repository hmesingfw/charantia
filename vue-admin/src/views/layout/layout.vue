<template>
    <div>
        <sidebar></sidebar>
    </div>
</template>

<script>
import Sidebar from './components/Sidebar/index.vue';
export default {
    name: 'layout',
    components: {
        Sidebar,
    }
}
</script>
