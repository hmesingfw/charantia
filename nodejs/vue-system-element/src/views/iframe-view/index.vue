<template>
    <div>
        <iframe src="http://localhost:3000/tables" frameborder="0" style="width:100%;height:100%" :style="{height:height}"></iframe>
    </div>
</template>

<script>
import { GetHeight } from '@/utils/sys'
export default {
    data () {
        return {
            height: GetHeight(90)
        }
    },
    created () { },
    mounted () { },
    methods: {},
}
</script>
<style lang="scss">
</style>
