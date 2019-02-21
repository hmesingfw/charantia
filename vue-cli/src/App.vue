<template>
    <div id="app">
        <img src="./assets/logo.png">
        <div>
            <p>
                If Element is successfully added to this project, you'll see an
                <code
                    v-text="'<el-button>'"
                ></code>
                below
            </p>
            <el-button v-if="inlist in list">el-button</el-button>
        </div>
    </div>
</template>

<script>

export default {
    name: 'app',
    data(){
        return{
            inlist:'122',
            list:['1','2','3']
        }
    },
    components: {
    },
    created () {
        this.$http.get('/test').then(res => {
            console.log(res);
        })
    }
}
</script>

<style>
#app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
}
</style>
