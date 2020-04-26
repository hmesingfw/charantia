<template>
    <div class="generate-form">
        <div v-for="(item,i) in datalist" :key="i">
            <el-form-item :label="item.label">
                <el-input v-if="item.name == 'el-input'" v-model="model[item.key]" v-bind="item.attr"></el-input>

                <el-select v-if="item.name == 'el-select'" v-model="model[item.key]" v-bind="item.attr" clearable @change="handleChange">
                    <el-option v-for="opt in enumList[item.option]" :key="opt.id" :label="opt.title" :value="opt.value"></el-option>
                </el-select>

                <el-radio-group v-if="item.name == 'el-switch' && (enumList[item.option] && enumList[item.option].length<=3)" v-model="model[item.key]" v-bind="item.attr" @change="handleChange">
                    <el-radio-button label>全部</el-radio-button>
                    <el-radio-button v-for="opt in enumList[item.option]" :key="opt.id" :label="opt.value">{{opt.title}}</el-radio-button>
                </el-radio-group>
                <el-select v-if="item.name == 'el-switch'  && (enumList[item.option] && enumList[item.option].length>3)" v-model="model[item.key]" v-bind="item.attr" clearable @change="handleChange">
                    <el-option v-for="opt in enumList[item.option]" :key="opt.id" :label="opt.title" :value="opt.value"></el-option>
                </el-select>

                <span v-if="item.name == 'time'">
                    <el-radio-group v-model="changevalue" @change="changeSf" style="margin-top:-2px">
                        <el-radio-button :label="7">最近一周</el-radio-button>
                        <el-radio-button :label="30">最近一个月</el-radio-button>
                        <el-radio-button :label="90">最近三个月</el-radio-button>
                    </el-radio-group>
                    <el-date-picker
                        v-model="timeValue"
                        type="daterange"
                        value-format="yyyy-MM-dd"
                        format="yyyy-MM-dd"
                        range-separator="-"
                        start-placeholder="开始时间"
                        end-placeholder="结束时间"
                        align="right"
                        @change="onChange"
                        :picker-options="pickerOptions"
                    ></el-date-picker>
                </span>
            </el-form-item>
            <slot v-if="i == slots"></slot>
        </div>
        <el-form-item>
            <el-tooltip class="item" effect="dark" content="查询" placement="top">
                <el-button @click="handleChange" icon="el-icon-search" circle></el-button>
            </el-tooltip>
            <el-tooltip class="item" effect="dark" content="刷新" placement="top">
                <el-button @click="flash" icon="el-icon-refresh" circle></el-button>
            </el-tooltip>
        </el-form-item>
    </div>
</template>
<script>
import { mapGetters } from 'vuex';
export default {
    computed: {
        ...mapGetters([
            'enumList'
        ])
    },
    props: {
        model: {
            type: Object
        },
        datalist: {
            type: Array,
            default: () => []
        },
        slots: { type: Number, default: 5 }
    },
    data() {
        return {
            timeValue: [],
            changevalue: '',
            pickerOptions: {},
        }
    },
    methods: {
        handleChange() {
            this.$emit('change');
        },
        flash() {
            this.timeValue = [];
            this.changevalue = '';
            this.QueryClose(this.model);
            this.$emit('change');
        },
        onChange(val) {
            this.changevalue = '';
            if (val && val.length > 1) {
                this.$set(this.model, 'startTime', val[0]);
                this.$set(this.model, 'endTime', val[1]);

            } else {
                this.$set(this.model, 'startTime', '');
                this.$set(this.model, 'endTime', '');
            }

            this.$emit('change');
        },
        /* 保存选择的时间 */
        changeSf(val) {
            const end = new Date();
            const start = new Date();

            start.setTime(start.getTime() - 3600 * 1000 * 24 * val);
            this.timeValue = [start, end];

            this.$set(this.model, 'startTime', start.Format('yyyy-MM-dd'));
            this.$set(this.model, 'endTime', end.Format('yyyy-MM-dd'));

            this.$emit('change');
        },

        QueryClose(form) {
            for (const key in form) {
                if (form[key] instanceof Array) {
                    form[key] = [];
                } else {
                    form[key] = '';
                }
            }
        }

    },
}
</script>
<style lang="scss">
.generate-form {
    display: flex;
    flex-wrap: wrap;

    @media screen and (min-width: 1860px) {
        .warp-line {
            padding-right: 260px;
        }
        .warp-line-100 {
            padding-right: 100px;
        }
    }
}
</style>