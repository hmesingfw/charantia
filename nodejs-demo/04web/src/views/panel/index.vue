<template>
    <div class="h-i">
        <panel-title></panel-title>
    </div>
</template>

<script>
import panelTitle from './panel-title'
export default {
    components: {
        panelTitle
    },
}
</script>
<style less="scss">
.h-i {
    background: url("../../assets/index.jpg");
    background-size: 100% 100%;
    height: 100%;
    position: fixed;
    width: 100%;
}
</style>