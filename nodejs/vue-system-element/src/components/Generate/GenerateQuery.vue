<template>
    <el-form-item class="header-handle">
        <el-tooltip class="item" effect="dark" content="新增" placement="top">
            <el-button @click="edit()" circle type="primary" icon="el-icon-plus"></el-button>
        </el-tooltip>
        <el-tooltip class="item" effect="dark" content="批量删除" placement="top">
            <el-button @click="HandleDelete(url, multipleSelection, callback);" icon="el-icon-delete" circle type="danger" v-show="multipleSelection.length>0"></el-button>
        </el-tooltip>
    </el-form-item>
</template>
<script>
export default {
    props: {
        edit: Function,
        url: String,
        callback: Function,
        multipleSelection: Array
    }
}
</script>