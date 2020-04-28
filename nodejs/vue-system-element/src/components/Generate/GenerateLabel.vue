<template>
    <div class>
        <el-popover placement="bottom-end" v-model="visible" popper-class="el-popover-generate-label">
            <el-radio-group v-model="params[keys]" class="generate-label-radio-group" @change="handleChange">
                <el-radio label>全部</el-radio>
                <el-radio v-for="opt in enumList[option]" :key="opt.id" :label="opt.value">{{opt.title}}</el-radio>
            </el-radio-group>

            <!-- <div style="text-align: right; margin: 0">
            <el-button size="mini" type="text" @click="visible = false">取消</el-button>
            <el-button type="primary" size="mini" @click="visible = false">确定</el-button>
            </div>-->
            <div slot="reference" :class="{ 'generate-label-color' : params[keys] }" style="cursor:pointer">
                <span>{{label}}</span>
                <i class="el-icon-arrow-down"></i>
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
        label: String,
        keys: { type: [String, Number] },
        option: { type: [String, Number] },
        params: { type: [Object] },
        call: { type: Function, default: () => { } }
    },

    data() {
        return {
            radio: 3,
            visible: false
        }
    },
    methods: {
        handleChange() {
            this.call();
            this.visible = false;
        }
    }
}
</script>
<style lang="scss">
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