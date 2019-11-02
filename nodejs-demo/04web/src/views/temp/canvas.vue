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
            msg: 'Welcome to Your Vue.js App',
            val: true,
            url: "",
            cicleList: [{
                ratio: '35'
            }, {
                ratio: '65'
            }, {
                ratio: '85'
            }]
        }
    }
}
</script>
