<template>
    <dialog-model v-model="value" title="投票信息" width="800" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="70px" :rules="rules" :model="form" ref="ruleForm" style="padding: 0 20px;">
            <el-form-item label="标题" prop="title">
                <el-input v-model="form.title" maxlength="30" show-word-limit></el-input>
            </el-form-item>

            <el-form-item label="内容" prop="content">
                <el-input type="textarea" :rows="5" v-model="form.content" maxlength="500" show-word-limit></el-input>
            </el-form-item>
            <el-form-item label="链接地址" prop="url">
                <el-input v-model="form.url" maxlength="120"></el-input>
            </el-form-item>
            <el-form-item label="结束截止" prop="endTime">
                <el-date-picker v-model="form.endTime" type="datetime" placeholder="请选择公告结束时间" value-format="yyyy-MM-dd mm:HH:ss"></el-date-picker>
            </el-form-item>
        </el-form>
    </dialog-model>
</template>
<script>
import { mapState } from 'vuex';
import VueUeditorWrap from 'vue-ueditor-wrap'; // ES6 Module
import { ueConfigText } from '@/utils/sys';
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
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                content: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            myConfig: ueConfigText,
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