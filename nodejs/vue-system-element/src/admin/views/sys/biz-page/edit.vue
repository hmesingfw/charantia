 <template>
    <dialog-model v-model="value" title="信息录入" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-card>
                <div slot="header" class="clearfix">
                    <span>基础信息</span>
                </div>
                <el-row>
                    <el-col :span="12">
                        <el-form-item label="单页类型" prop="pageType">
                            <el-input v-model="form.pageType" maxlength="32" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="标题" prop="title">
                            <el-input v-model="form.title" maxlength="32" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="描述" prop="description">
                            <el-input v-model="form.description" maxlength="255" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="分组" prop="pageGroup">
                            <el-select v-model="form.pageGroup" maxlength="1" :disabled="false">
                                <el-option v-for="item in statusList" :key="item.id" :label="item.title" :value="item.value"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="状态" prop="status">
                            <el-switch class="switch-style" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-card>
            <el-card style="margin-top:20px">
                <div slot="header" class="clearfix">
                    <span>内容</span>
                </div>
                <el-form-item label-width="0px" prop="content" class="vue-ueditor-wrap-s">
                    <!-- <el-input v-model="form.content" maxlength="2048" :disabled="false" show-word-limit></el-input> -->
                    <vue-ueditor-wrap v-model="form.content" :config="myConfig"></vue-ueditor-wrap>
                </el-form-item>
            </el-card>
        </el-form>
    </dialog-model>
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
        value: { type: [Boolean, String] },
        form: Object,
        requestType: { type: String, default: '' },
        callback: Function,
        url: { type: String, default: '' },
    },
    data() {
        return {
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            myConfig: ueConfig,
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