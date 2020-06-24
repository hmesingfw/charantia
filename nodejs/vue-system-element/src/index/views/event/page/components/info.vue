<template>
    <el-row>
        <div class="app-main-table">
            <el-row style="padding:20px 40px 40px">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="info" ref="ruleForm">
                    <span class="info-column-title">活动信息</span>
                    <el-divider></el-divider>
                    <el-col :xl="14" :md="12">
                        <el-form-item label="活动名称" prop="title">
                            <el-input v-model="form.title" maxlength="32"></el-input>
                        </el-form-item>

                        <el-form-item label="活动地址" prop="coverId">
                            <el-row>
                                <el-col :span="10">
                                    <el-cascader v-model="form.cityvalue" :options="cityDataChildren" :props="{value:'id'}" style="width: 100%;"></el-cascader>
                                </el-col>

                                <el-col :span="14">
                                    <el-input v-model="form.address" maxlength="60" show-word-limit placeholder="详细地址"></el-input>
                                </el-col>
                            </el-row>
                        </el-form-item>

                        <el-form-item label="描述" prop="description">
                            <el-input type="textarea" :rows="4" v-model="form.description" maxlength="512" show-word-limit></el-input>
                        </el-form-item>
                        <el-form-item label="内容" prop="content" class="vue-ueditor-wrap-s">
                            <vue-ueditor-wrap v-model="form.content" :config="myConfig"></vue-ueditor-wrap>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="8" :md="12">
                        <el-form-item label="活动封面" prop="coverId">
                            <c-file v-model="form.coverId" fileUrl="api"></c-file>
                        </el-form-item>
                    </el-col>

                    <!-- <el-col>
                        <span class="info-column-title">活动详情</span>

                        <el-divider></el-divider>
                        <el-form-item label-width="0px" prop="description" class="vue-ueditor-wrap-s">
                            <vue-ueditor-wrap v-model="form.description" :config="myConfig"></vue-ueditor-wrap>
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