<template>
    <dialog-alert v-model="value" title="投票信息" width="500px" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="50px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="标题" prop="title">
                <el-input v-model="form.title" maxlength="32"></el-input>
            </el-form-item>

            <el-form-item label="封面" prop="coverId">
                <c-file v-model="form.coverId" fileUrl="api"></c-file>
            </el-form-item>
            <el-form-item label="报名截止" prop="expireTime">
                <el-date-picker v-model="form.expireTime" type="datetime" placeholder="报名截止时间" format="yyyy-MM-dd mm:HH:ss"></el-date-picker>
            </el-form-item>

            <el-form-item label="活动时间" prop="postTime">
                <el-date-picker v-model="form.postTime" type="datetimerange" range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期" format="yyyy-MM-dd mm:HH:ss"></el-date-picker>
            </el-form-item>

            <el-form-item label="活动地址" prop="coverId">
                <el-cascader v-model="form.cityvalue" :options="cityDataChildren" :props="{value:'id'}"></el-cascader>
            </el-form-item>

            <el-card style="margin-top:20px">
                <div slot="header" class="clearfix">
                    <span>内容</span>
                </div>
                <el-form-item label-width="0px" prop="description" class="vue-ueditor-wrap-s">
                    <vue-ueditor-wrap v-model="form.description" :config="myConfig"></vue-ueditor-wrap>
                </el-form-item>
            </el-card>
        </el-form>
    </dialog-alert>
</template>
<script>
import { mapState } from 'vuex';
import VueUeditorWrap from 'vue-ueditor-wrap'; // ES6 Module
import { ueConfig } from '@/utils/sys';
import cityDataChildren from '@/config/city-data-children'
export default {
    components: {
        VueUeditorWrap
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    props: {
        value: { type: [Boolean, String] },
        form: Object,
        requestType: String,
        callback: Function,
        url: String,
    },
    data() {
        return {
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            myConfig: ueConfig,
            cityDataChildren: cityDataChildren,
        }
    },
    methods: {
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.ReqData(this.url, this.form, this.requestType);
                    if (issucc) {

                        this.callback();
                        this.$emit('input', false);
                    }
                    this.loadingButton = false;
                }
            });
        },
        colse() {
            this.$emit('input', false);
        }
    }
}
</script>