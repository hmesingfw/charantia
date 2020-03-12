<template>
    <div>
        <el-form-item v-for="(item,i) in datalist" :key="i" :label="item.label">
            <component v-if="item.name == 'el-input'" :is="item.name" v-model="model[item.key]" v-bind="item.attr"></component>
            <component v-if="item.name == 'el-select'" :is="item.name" v-model="model[item.key]" v-bind="item.attr">
                <el-option v-for="opt in item.option" :key="opt.value" :label="opt.label" :value="opt.value"></el-option>
            </component>
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
                { name: 'el-select', key: 'status', label: "标题", attr: { placeholder: '请输入' }, option: [{ label: '启用', value: '0' }, { label: '禁用', value: '1' }] },
            ]
        },
    }
}
</script>