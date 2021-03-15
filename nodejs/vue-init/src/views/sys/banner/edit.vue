 <template>
    <dialog-model v-model="value" title="广告信息" width="1200" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-row>
                <el-col :span="12">
                    <el-form-item label="标题" prop="title">
                        <el-input v-model="form.title" maxlength="16" :disabled="false" show-word-limit></el-input>
                    </el-form-item>
                    <el-form-item label="描述" prop="description">
                        <el-input type="textarea" v-model="form.description" maxlength="200" :disabled="false" show-word-limit></el-input>
                    </el-form-item>

                    <el-form-item label="文字广告" prop="advsText">
                        <el-input v-model="form.advsText" maxlength="64" :disabled="false" show-word-limit></el-input>
                    </el-form-item>
                    <el-form-item label="广告链接" prop="link">
                        <el-input v-model="form.link" maxlength="255" :disabled="false"></el-input>
                    </el-form-item>

                    <el-form-item label="时间" prop="times">
                        <el-date-picker v-model="times" value-format="yyyy-MM-dd mm:HH:ss" type="datetimerange" range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
                    </el-form-item>
                    <el-form-item label="位置" prop="images">
                        <el-select v-model="form.positionId" placeholder="请选择内容">
                            <el-option v-for="opt in posList" :key="opt.posCode" :label="opt.title" :value="opt.posCode"></el-option>
                        </el-select>
                    </el-form-item>

                    <el-form-item label="排序" prop="sort">
                        <el-input-number v-model="form.sort" :min="1" :max="10000"></el-input-number>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="封面" prop="images">
                        <c-file v-model="form.images" :fileUrl="$api.sys.upload" group="banner" tip="只能上传jpg/png文件，且不超过2M,推荐分辨率 1920x1000"></c-file>
                    </el-form-item>
                </el-col>
            </el-row>
        </el-form>
    </dialog-model>
</template>
<script>
export default {
    props: {
        value: { type: [Boolean, String] },
        form: Object,
        requestType: { type: String, default: '' },
        callback: Function,
        url: { type: String, default: '' },
    },
    watch: {
        form: {
            handler(val) {
                this.setTime(val);
            }, deep: true
        }
    },
    data() {
        return {
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            posList: [],
            times: [],
        }
    },
    created() {
        this.init();
        this.setTime(this.form);
    },
    methods: {
        setTime(form) {
            this.times = [form.startDate, form.endDate];
        },
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    if (this.times && this.times.length > 0) {
                        this.$set(this.form, 'startDate', this.times[0]);
                        this.$set(this.form, 'endDate', this.times[1]);
                    } else {
                        this.$set(this.form, 'startDate', '');
                        this.$set(this.form, 'endDate', '');
                    }
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
        },
        init() {

            this.$http.get(this.$api.sys.banner, {
                params: { size: 1, limit: 1000, }
            }).then(res => {
                this.posList = res.data.data.list;
            })
        },
    }
}
</script>