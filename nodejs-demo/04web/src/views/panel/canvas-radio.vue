<template>
    <div class="circle">
        <canvas-circle v-for="(item,index) in cicleList" :key="index" :percent="item.ratio" :id="index"></canvas-circle>
    </div>
</template>
<script>
import canvasCircle from '@/components/CanvasCircle'
export default {
    components: {
        canvasCircle
    },
    data() {
        return {
            cicleList: [{
                ratio: '35'
            },]
        }
    }
}
</script>
