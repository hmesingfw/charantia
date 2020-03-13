<template>
    <div>
        <el-form-item v-for="(item,i) in datalist" :key="i" :label="item.label">
            <component v-if="item.name == 'el-input'" :is="item.name" v-model="model[item.key]" v-bind="item.attr"></component>
            <component v-if="item.name == 'el-select'" :is="item.name" v-model="model[item.key]" v-bind="item.attr">
                <el-option v-for="opt in enumList[item.option]" :key="opt.value" :label="opt.title" :value="opt.value"></el-option>
            </component>
        </el-form-item>
    </div>
</template>
<script>
import { mapState } from 'vuex';
export default {
    computed: {
        ...mapState({
            enumList: state => state.enumList.data,
        })
    },
    props: {
        model: {
            type: Object
        },
        datalist: {
            type: Array,
            default: () => [
                { name: 'el-input', key: 'title', label: "标题", attr: { placeholder: '请输入' } },
                { name: 'el-select', key: 'status', label: "标题", attr: { placeholder: '' }, option: 'statusList' },
            ]
        },
    }
}
</script>