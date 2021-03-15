<template>
    <el-popconfirm title="修改排序" @onConfirm="UpdateField(data, url, dataKey, callback)">
        <el-input-number slot="reference" v-model="data[dataKey]" controls-position="right" class="el-input-number-table" :min="min" :max="max" />
    </el-popconfirm>
</template>
<script>

export default {

    props: {
        data: Object, // 数据对象
        url: String, // 请求地址
        dataKey: { type: [String, Number] }, // 修改字段
        callback: Function, // 回调方法
        min: { type: [Number], default: 1, },
        max: { type: [Number], default: 10000, }
    }
}
</script>
