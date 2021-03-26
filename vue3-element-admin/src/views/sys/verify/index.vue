<template>
    <div class="app-main-table" style="padding:20px">
        <slide-verify :l="42" :r="10" :w="310" :h="155" :slider-text="text" :imgs="imgs" @success="onSuccess" @fail="onFail" @refresh="onRefresh" />
        <div>{{ msg }}</div>
    </div>
</template>

<script>
import Vue from 'vue';
import SlideVerify from 'vue-monoplasty-slide-verify';
Vue.use(SlideVerify);
export default {
    name: 'Verify',
    data() {
        return {
            msg: '',
            text: '向右滑',
            imgs: ['https://fuss10.elemecdn.com/a/3f/3302e58f9a181d2509f3dc0fa68b0jpeg.jpeg',
                'https://fuss10.elemecdn.com/1/34/19aa98b1fcb2781c4fba33d850549jpeg.jpeg',
                'https://fuss10.elemecdn.com/0/6f/e35ff375812e6b0020b6b4e8f9583jpeg.jpeg',],
        }
    },
    methods: {
        onSuccess(res, l) {
            console.log(res, l);
            this.msg = 'login success'
        },
        onFail() {
            this.msg = ''
        },
        onRefresh() {
            this.msg = ''
        }
    }
}
</script>
