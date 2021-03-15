<template>
    <div class>
        <el-popover v-model="visible" placement="bottom-end" popper-class="el-popover-generate-label">
            <el-radio-group v-if="url == ''" v-model="params[dataKey]" class="generate-label-radio-group" @change="handleChange">
                <el-radio label>全部</el-radio>
                <el-radio v-for="opt in enumList[option]" :key="opt.id" :label="opt.value">{{ opt.title }}</el-radio>
            </el-radio-group>

            <el-radio-group v-else v-model="params[dataKey]" class="generate-label-radio-group" @change="handleChange">
                <el-radio label>全部</el-radio>
                <el-radio v-for="opt in dataList" :key="opt[res.id]" :label="opt[res.id]">{{ opt[res.label] }}</el-radio>
            </el-radio-group>

            <div slot="reference" :class="{ 'generate-label-color' : params[dataKey] }" style="cursor:pointer">
                <span>{{ label }}</span>
                <i class="el-icon-arrow-down" />
            </div>
        </el-popover>
    </div>
</template>
<script>
import { mapGetters } from 'vuex'
export default {
    computed: {
        ...mapGetters([
            'enumList'
        ])
    },
    props: {
        label: String, //  名称
        dataKey: { type: [String, Number] }, // 查询KEY
        params: { type: [Object] }, // 查询对象，对象中包涵KEY
        option: { type: [String, Number] }, // 查询值
        callback: { type: Function, default: () => { } },

        url: { type: String, default: '' }, // 请求地址
        res: { type: Object, default: () => ({ key: 'id', label: 'label' }) } // respones 接收值
    },

    created() {
        this.init();
    },

    data() {
        return {
            visible: false,

            dataList: [] // 查询加载数据
        }
    },
    methods: {
        init() {
            if (!this.url) return;
            this.$http.get(this.url, { params: { page: 1, limit: 1000 } }).then(res => {
                this.dataList = res.data.data.list;
            })
        },
        handleChange() {
            this.callback();
            this.visible = false;
        }
    }
}
</script>
<style lang="scss" scoped>
.el-popover-generate-label {
    min-width: 50px;
}
.generate-label-radio-group {
    display: flex;
    flex-direction: column;

    .el-radio {
        margin-right: 0;
        margin-bottom: 10px;
    }
    .el-radio:last-child {
        margin-bottom: 0px;
    }
}
.generate-label-color {
    color: #409eff;
}
</style>
