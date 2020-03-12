<template>
    <div>
        <el-form-item v-for="(item,i) in datalist" :key="i" :label="item.label">
            <component :is="item.name" v-model="model[item.key]" v-bind="item.attr"></component>
        </el-form-item>
    </div>
</template>
<script>
export default {
    props: {
        model: {
            type: Object
        },
        datalist: {
            type: Array,
            default: () => [
                { name: 'el-input', key: 'title', label: "标题", attr: { placeholder: '请输入' } },
            ]
        },
    }
}
</script>