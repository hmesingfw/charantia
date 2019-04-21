Vue.component('kt-form', {
    template: `
        <el-dialog :title="title" :visible.sync="dialog" width="60%" :before-close="handleClose">

            <el-form :model="form" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" size="small">
                <el-form-item label="编号" prop="id" width="50%">
                    <el-input v-model="form.id"></el-input>
                </el-form-item>
                <el-form-item label="姓名" prop="name" width="50%">
                    <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item label="性别" prop="sex" width="50%">      
                    <el-select v-model="form.sex" placeholder="请选择性别">
                        <el-option label="男" value="1"></el-option>
                        <el-option label="女" value="2"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="爱好" prop="hobby" width="50%">
                    <el-input v-model="form.hobby"></el-input>
                </el-form-item>
                <el-form-item label="地址" prop="address" width="50%">
                    <el-input v-model="form.address"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
                    <el-button @click="resetForm('ruleForm')">重置</el-button>
                </el-form-item>
            </el-form>
        </el-dialog>
    `,
    props: {
        title: [String],
        dialog: [Boolean, String],
        form: [Object],
        rules: [Object],
    },
    data: function () {
        return {}
    },
    methods: {
        handleClose() {
            this.$emit('close');
        },
        resetForm(formName) {
            this.$refs[formName].resetFields();
        },
        submitForm() {
            console.log(this.form);
            this.$emit('close');
            this.$message({
                type: 'success',
                message: '操作成功'
            })
        }
    }

})