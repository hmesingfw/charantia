<template>
    <el-row>
        <div class="app-main-table">
            <el-row style="padding:40px">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="info" ref="ruleForm">
                    <!-- <span class="info-column-title">基本信息</span> -->
                    <!-- <el-divider></el-divider> -->
                    <!-- <el-col :xl="14" :md="12"> -->
                    <el-col :xl="18" :md="24">
                        <el-form-item label="名称" prop="title">
                            <el-input v-model="form.title" maxlength="32" style="width:270px" placeholder="请输入活动名称"></el-input>
                        </el-form-item>
                        <el-form-item label="封面" prop="coverId">
                            <c-file v-model="form.coverId" fileUrl="api"></c-file>
                        </el-form-item>
                        <el-form-item label="截止" prop="expireTime">
                            <el-date-picker v-model="form.expireTime" type="datetime" placeholder="报名截止时间" format="yyyy-MM-dd mm:HH:ss"></el-date-picker>
                        </el-form-item>
                        <el-form-item label="时间" prop="postTime">
                            <el-date-picker v-model="form.postTime" type="datetimerange" range-separator="-" start-placeholder="活动开始日期" end-placeholder="活动结束日期" format="yyyy-MM-dd mm:HH:ss"></el-date-picker>
                        </el-form-item>
                        <el-form-item label="地址" prop="coverId">
                            <el-row>
                                <el-col :span="10" style="margin-bottom:10px">
                                    <el-cascader v-model="form.cityvalue" :options="cityDataChildren" :props="{value:'id'}" style="width: 100%;"></el-cascader>
                                </el-col>
                                <el-input v-model="form.address" maxlength="60" show-word-limit placeholder="详细地址"></el-input>
                                <el-col :span="14"></el-col>
                            </el-row>
                        </el-form-item>

                        <el-form-item label="描述" prop="description">
                            <el-input type="textarea" :rows="4" v-model="form.description" maxlength="512" show-word-limit></el-input>
                        </el-form-item>
                        <el-form-item label="内容" prop="content" class="vue-ueditor-wrap-s">
                            <vue-ueditor-wrap v-model="form.content" :config="myConfig"></vue-ueditor-wrap>
                        </el-form-item>
                    </el-col>
                    <!-- <el-col :xl="8" :md="12">
                        <el-form-item label="活动封面" prop="coverId">
                            <c-file v-model="form.coverId" fileUrl="api"></c-file>
                        </el-form-item>
                    </el-col>-->
                </el-form>
            </el-row>
        </div>
    </el-row>
</template>
<script>
import cityDataChildren from '@/config/city-data-children'

import vueUeditorWrap from 'vue-ueditor-wrap';
import { mapState } from 'vuex';
import { ueConfig } from '@/utils/sys';

export default {
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    components: {
        vueUeditorWrap
    },
    props: {
        info: Object,
    },
    data() {
        return {
            url: 'http://',
            form: {},
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            myConfig: { ...ueConfig, initialFrameHeight: 400 },

            cityDataChildren: cityDataChildren,

        }
    },
    methods: {
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    await this.ReqData(this.$api.sys.tenant, this.info, 'put');

                    this.loadingButton = false;
                }
            });
        },
    }
}
</script>