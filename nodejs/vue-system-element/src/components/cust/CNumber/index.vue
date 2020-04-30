<template>
    <el-popconfirm title="修改排序" @onConfirm="UpdateField(data, url, dataKey, callback)">
        <el-input-number v-model="data[dataKey]" slot="reference" controls-position="right" class="el-input-number-table" :min="1" :max="10000"></el-input-number>
    </el-popconfirm>
</template>
<script>

export default {

    props: {
        data: Object,                   // 数据对象
        url: String,                    // 请求地址
        dataKey: { type: [String, Number] },                // 修改字段
        callback: Function,             // 回调方法  
    }
}
</script>