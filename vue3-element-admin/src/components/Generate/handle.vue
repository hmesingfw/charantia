<template>
    <el-row class="handle-container">
        <!-- <el-form-item class="header-handle"> -->
        <!-- <el-tooltip class="item" effect="dark" content="新增" placement="top"> -->
        <el-button v-permission="intPer" type="primary" icon="el-icon-plus" @click="edit()">新增</el-button>
        <!-- </el-tooltip> -->
        <!-- <el-tooltip class="item" effect="dark" content="批量删除" placement="top"> -->
        <el-button v-permission="delPer" icon="el-icon-delete" type="danger" :disabled="!multipleSelection.length>0" @click="HandleDelete(url, multipleSelection, callback);">批量删除</el-button>
        <!-- </el-tooltip> -->
        <!-- </el-form-item> -->
        <slot />
    </el-row>
</template>
<script>
export default {
    props: {
        edit: Function,
        url: String,
        callback: Function,
        multipleSelection: { type: Array, default: () => [] },
        intPer: {
            type: String, default: ''
        },
        delPer: {
            type: String, default: ''
        },
    }
}
</script>

<style lang="scss">
.handle-container {
    padding: 20px;
}
</style>
