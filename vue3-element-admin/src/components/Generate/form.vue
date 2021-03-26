<template>
    <el-row class="generate-form">
        <div v-for="(item,i) in datalist" v-show="i < showItem ? true : custStatus" :key="i" class="group">
            <slot v-if="i == slots" />
            <el-form-item :label="item.label">
                <el-input v-if="item.name == 'el-input'" v-model="model[item.key]" v-bind="item.attr" clearable @keyup.enter.native="handleChange" />

                <el-select v-if="item.name == 'el-select'" v-model="model[item.key]" v-bind="item.attr" clearable @change="handleChange">
                    <el-option v-for="opt in enumList[item.option]" :key="opt.id" :label="opt.title" :value="opt.value" />
                </el-select>

                <el-radio-group
                    v-if="item.name == 'el-switch' && (enumList[item.option] && enumList[item.option].length<=3)"
                    v-model="model[item.key]"
                    v-bind="item.attr"
                    style="margin-top:-2px"
                    @change="handleChange"
                >
                    <el-radio-button label>全部</el-radio-button>
                    <el-radio-button v-for="opt in enumList[item.option]" :key="opt.id" :label="opt.value">{{ opt.title }}</el-radio-button>
                </el-radio-group>
                <el-select v-if="item.name == 'el-switch' && (enumList[item.option] && enumList[item.option].length>3)" v-model="model[item.key]" v-bind="item.attr" clearable @change="handleChange">
                    <el-option value label="全部" />
                    <el-option v-for="opt in enumList[item.option]" :key="opt.id" :label="opt.title" :value="opt.value" />
                </el-select>

                <span v-if="item.name == 'time'">
                    <el-radio-group v-model="changevalue" style="margin-top:-2px" class="radio-time" @change="changeSf">
                        <el-radio-button :label="7">最近一周</el-radio-button>
                        <el-radio-button :label="30">最近一个月</el-radio-button>
                        <el-radio-button :label="90">最近三个月</el-radio-button>
                    </el-radio-group>
                    <el-date-picker
                        v-model="timeValue"
                        type="daterange"
                        value-format="yyyy-MM-dd HH:mm:ss"
                        format="yyyy-MM-dd"
                        range-separator="-"
                        start-placeholder="请选择开始时间"
                        end-placeholder="请选择结束时间"
                        align="right"
                        :picker-options="pickerOptions"
                        @change="onChange"
                    />
                </span>
            </el-form-item>
        </div>
        <slot v-if="slots > datalist.length" />

        <el-form-item>
            <!-- <el-tooltip class="item" effect="dark" content="查询" placement="top"> -->
            <el-button icon="el-icon-search" type="primary" @click="handleChange" @keyup.enter.native="handleChange">查询</el-button>
            <!-- </el-tooltip> -->
            <!-- <el-tooltip class="item" effect="dark" content="重置" placement="top"> -->
            <el-button icon="el-icon-refresh" type="primary" @click="flash">重置</el-button>
            <!-- </el-tooltip> -->
            <el-button v-if="datalist.length > showItem" v-show="custStatus == false" icon="el-icon-arrow-down" type="text" @click="custStatus = true">展开</el-button>
            <el-button v-if="datalist.length > showItem" v-show="custStatus == true" icon="el-icon-arrow-up" type="text" @click="custStatus = false">收起</el-button>
        </el-form-item>
    </el-row>
</template>
<script>
import { mapGetters } from 'vuex';
export default {
    computed: {
        ...mapGetters(['enumList']),
        // window.screen.width

    },
    props: {
        model: {
            type: Object
        },
        datalist: {
            type: Array,
            default: () => []
        },
        slots: { type: Number, default: 5 },
        showItem: { type: Number, default: 3 }
    },
    data() {
        return {
            timeValue: [],
            changevalue: '',
            pickerOptions: {},

            // pickerOptions: {
            //     shortcuts: [{
            //         text: '最近一周',
            //         onClick(picker) {
            //             const end = new Date();
            //             const start = new Date();
            //             start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
            //             picker.$emit('pick', [start, end]);
            //         }
            //     }, {
            //         text: '最近一个月',
            //         onClick(picker) {
            //             const end = new Date();
            //             const start = new Date();
            //             start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
            //             picker.$emit('pick', [start, end]);
            //         }
            //     }, {
            //         text: '最近三个月',
            //         onClick(picker) {
            //             const end = new Date();
            //             const start = new Date();
            //             start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
            //             picker.$emit('pick', [start, end]);
            //         }
            //     }]
            // },
            custStatus: false
        };
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
            this.$emit('flash');
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

            // this.$set(this.model, 'startTime', start.getTime());
            // this.$set(this.model, 'endTime', end.getTime());
            this.$set(this.model, 'startTime', start.Format('yyyy-MM-dd') + ' 00:00:00');
            this.$set(this.model, 'endTime', end.Format('yyyy-MM-dd') + ' 00:00:00');

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
    }
};
</script>
<style lang="scss">
.generate-form {
    display: flex;
    flex-wrap: wrap;

    .group {
        margin-right: 10px;
        display: flex;
        flex-wrap: wrap;
    }

    @media screen and (min-width: 1860px) {
        .warp-line {
            padding-right: 260px;
        }
        .warp-line-100 {
            padding-right: 100px;
        }
    }
    @media (max-width: 1600px) {
        .radio-time {
            display: none;
        }
    }
}
</style>
