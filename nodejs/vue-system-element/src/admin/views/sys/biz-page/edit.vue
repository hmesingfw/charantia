 <template>
    <!-- <dialog-model v-model="value" title="信息录入" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false"> -->
    <div class="app-main-table">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-card>
                <div slot="header" class="clearfix">
                    <span>基础信息</span>
                </div>
                <el-row>
                    <!-- <el-col :span="12">
                        <el-form-item label="单页类型" prop="pageType">
                            <el-input v-model="form.pageType" maxlength="32" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>-->
                    <el-col :span="16">
                        <el-form-item label="标题" prop="title">
                            <el-input v-model="form.title" maxlength="32" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="16">
                        <el-form-item label="描述" prop="description">
                            <el-input type="textarea" :row="3" v-model="form.description" maxlength="255" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                    <!-- <el-col :span="12">
                        <el-form-item label="分组" prop="pageGroup">
                            <el-select v-model="form.pageGroup" maxlength="1" :disabled="false">
                                <el-option v-for="item in statusList" :key="item.id" :label="item.title" :value="item.value"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>-->
                    <el-col :span="16">
                        <el-form-item label="状态" prop="status">
                            <el-switch class="switch-style" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
                        </el-form-item>
                    </el-col>
                    <el-col :span="16">
                        <el-form-item>
                            <el-button type="primary" @click="handleUpdate">保存</el-button>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-card>
            <el-card style="margin-top:20px">
                <div slot="header" class="clearfix">
                    <span>内容</span>
                </div>
                <el-form-item label-width="0px" prop="content" class="vue-ueditor-wrap-s">
                    <vue-ueditor-wrap v-model="form.content" :config="myConfig"></vue-ueditor-wrap>
                </el-form-item>
            </el-card>
        </el-form>
    </div>
    <!-- </dialog-model> -->
</template>
<script>
import {
    mapState
} from 'vuex';
import VueUeditorWrap from 'vue-ueditor-wrap'; // ES6 Module
import { ueConfig } from '@/utils/sys';

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
        // value: { type: [Boolean, String] },
        info: Object,
        // requestType: { type: String, default: '' },
        // callback: Function,
        // url: { type: String, default: '' },
    },
    crated() {
        this.query();
    },
    watch: {
        info: {
            handler() {
                this.query();
            }
        },
        deep: true,
    },
    data() {
        return {
            form: {},
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            myConfig: ueConfig,
        }
    },
    methods: {
        query() {
            this.$http.get(this.$api.sys.bizPage, {
                params: {
                    pageType: this.info.itemValue,
                    pageGroup: this.info.dictCode
                }
            }).then(res => {
                console.log(res);
                this.form = res.data.data;
            })
        },
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let form = {
                        ...this.form,
                        pageType: this.info.itemValue,
                        pageGroup: this.info.dictCode
                    }
                    let issucc = await this.ReqData(this.$api.sys.bizPage, form, 'post');
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