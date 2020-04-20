<template>
    <div>
        <el-form-item v-for="(item,i) in datalist" :key="i" :label="item.label">
            <el-input v-if="item.name == 'el-input'" v-model="model[item.key]" v-bind="item.attr"></el-input>

            <el-select v-if="item.name == 'el-select' && enumList[item.option].length >= 4" v-model="model[item.key]" v-bind="item.attr">
                <el-option v-for="opt in enumList[item.option]" :key="opt.value" :label="opt.title" :value="opt.value"></el-option>
            </el-select>

            <el-radio-group v-if="item.name == 'el-select' && enumList[item.option].length < 4" v-model="model[item.key]" v-bind="item.attr" @change="handleChange">
                <el-radio-button label>全部</el-radio-button>
                <el-radio-button v-for="opt in enumList[item.option]" :key="opt.value" :label="opt.value">{{opt.title}}</el-radio-button>
            </el-radio-group>

            <el-radio-group v-if="item.name == 'el-switch'" v-model="model[item.key]" v-bind="item.attr" @change="handleChange">
                <el-radio-button label>全部</el-radio-button>
                <el-radio-button v-for="opt in enumList[item.option]" :key="opt.value" :label="opt.value">{{opt.title}}</el-radio-button>
            </el-radio-group>
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
                // { name: 'el-input', key: 'title', label: "标题", attr: { placeholder: '请输入' } },
                // { name: 'el-select', key: 'status', label: "状态", attr: { placeholder: '' }, option: 'statusList' },
            ]
        },
    },
    methods: {
        handleChange() {
            this.$emit('change');
        }
    },
}
</script>