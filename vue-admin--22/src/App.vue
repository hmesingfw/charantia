<template>
    <div id="app">
        <img src="./assets/logo.png">
        <div>
            <p>
                If Element is successfully added to this project, you'll see an
                below
            </p>
            <el-button>{{ $t('login.title') }}</el-button>
        </div>
    </div>
</template>

<script>


export default {
    name: 'app',
    components: {
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
