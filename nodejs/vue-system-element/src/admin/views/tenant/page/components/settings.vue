<template>
    <el-row>
        <div class="app-main-table">
            <el-row style="padding:20px 40px 40px" :gutter="20">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="info" ref="ruleForm">
                    <span class="info-column-title">基础设置</span>
                    <el-divider></el-divider>
                    <el-col :xl="10" :md="20">
                        <el-form-item label="域名前缀" prop="domain">
                            <el-input v-model="info.domain" maxlength="128" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="10" :md="20">
                        <el-form-item label="账号限制数" prop="accountLimit">
                            <el-input v-model="info.accountLimit" maxlength="10" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="10" :md="20">
                        <el-form-item label="授权时间" prop="startTime">
                            <!-- <el-date-picker v-model="info.startTime" type="date" placeholder="选择日期"></el-date-picker> -->
                            <el-date-picker
                                v-model="pickerTime"
                                type="daterange"
                                align="right"
                                unlink-panels
                                range-separator="-"
                                format="yyyy-MM-dd"
                                start-placeholder="开始日期"
                                end-placeholder="结束日期"
                                :picker-options="pickerOptions"
                            ></el-date-picker>
                        </el-form-item>
                    </el-col>
                    <!-- <el-col :xl="10" :md="20">
                        <el-form-item label="授权结束时间" prop="endTime">
                            <el-date-picker v-model="info.endTime" type="date" placeholder="选择日期"></el-date-picker>
                        </el-form-item>
                    </el-col>-->

                    <el-col :xl="10" :md="20">
                        <el-form-item label="网盘容量" prop="diskCapacity">
                            <el-input v-model="info.diskCapacity" maxlength="10" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="20" :md="20" style="margin-top:20px">
                        <el-form-item>
                            <el-button type="primary" @click="handleUpdate">保存</el-button>
                        </el-form-item>
                    </el-col>
                </el-form>
            </el-row>
        </div>
    </el-row>
</template>
<script>
export default {
    data() {
        return {
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            pickerTime: [this.info.startTime, this.info.endTime],
            pickerOptions: {
                shortcuts: [{
                    text: '最近一周',
                    onClick(picker) {
                        const end = new Date(); const start = new Date(); start.setTime(start.getTime() - 3600 * 1000 * 24 * 7); picker.$emit('pick', [start, end]);
                    }
                }, {
                    text: '最近一个月',
                    onClick(picker) {
                        const end = new Date(); const start = new Date(); start.setTime(start.getTime() - 3600 * 1000 * 24 * 30); picker.$emit('pick', [start, end]);
                    }
                }, {
                    text: '最近三个月',
                    onClick(picker) {
                        const end = new Date(); const start = new Date(); start.setTime(start.getTime() - 3600 * 1000 * 24 * 90); picker.$emit('pick', [start, end]);
                    }
                }, {
                    text: '最近一年',
                    onClick(picker) {
                        const end = new Date(); const start = new Date(); start.setTime(start.getTime() - 3600 * 1000 * 24 * 365); picker.$emit('pick', [start, end]);
                    }
                }, {
                    text: '最近三年',
                    onClick(picker) {
                        const end = new Date(); const start = new Date(); start.setTime(start.getTime() - 3600 * 1000 * 24 * 365 * 3); picker.$emit('pick', [start, end]);
                    }
                }]
            },
        }
    },
    props: {
        info: Object,
    },
    methods: {
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    if (this.pickerTime.length > 1) {
                        this.info.startTime = this.pickerTime[0];
                        this.info.endTime = this.pickerTime[1];
                    }
                    let issucc = await this.ReqData(this.$api.sys.tenant, this.info, 'put');
                    if (issucc) {
                        console.log('-');
                    }
                    this.loadingButton = false;
                }
            });
        },
    }
}
</script>