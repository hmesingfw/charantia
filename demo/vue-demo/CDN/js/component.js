// 第一步 实现Vue.component() 方法         Vue.component('name', options)      name 组件名  options 选项
Vue.component('kt-form', {
    // 第二步，编写 template模版
    template: `
        <el-dialog :title="title" :visible.sync="dialog" width="50%" :before-close="handleClose">

            <el-form :model="form" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" size="small">
                <el-form-item label="编号" prop="id" width="50%">
                    <el-input v-model="form.id"></el-input>
                </el-form-item>
                <el-form-item label="姓名" prop="name" width="50%" placeholder="请输入内容">
                    <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item label="性别" prop="sex" width="50%">      
                    <el-select v-model="form.sex" placeholder="请选择性别">
                        <el-option label="男" value="1"></el-option>
                        <el-option label="女" value="2"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="爱好" prop="hobby" width="50%"> 
                    <el-radio-group v-model="form.hobby">
                        <el-radio label="篮球">篮球</el-radio>
                        <el-radio label="足球">足球</el-radio>
                        <el-radio label="乒乓球">乒乓球</el-radio>
                        <el-radio label="羽毛球">羽毛球</el-radio>
                        <el-radio label="冰球">冰球</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="生日" prop="hobby" width="50%"> 
                    <el-date-picker v-model="form.datetime" type="date" placeholder="选择日期"></el-date-picker>
                </el-form-item>    
                <el-form-item label="地址" prop="address" width="50%">
                    <el-input v-model="form.address" type="textarea" placeholder="请输入内容"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
                    <el-button @click="handleClose">取消</el-button>
                </el-form-item>
            </el-form>
        </el-dialog>
    `,
    // 第二步，编写组件参数，与template中的数据绑定
    props: {
        title: [String],
        dialog: [Boolean, String],
        form: [Object],
        rules: [Object],
    },
    // 第三步，编写组件方法，
    methods: {
        /** 关闭弹框 */
        handleClose() {
            this.$emit('close', true);
        },
        /**
         * 重置表单数据
         * formName 表单中ref值
         */
        resetForm(formName) {
            this.$refs[formName].resetFields();
        },
        /**
         * 保存表单数据
         * formName 表单中ref值
         */
        submitForm(formName) {
            /** 数据验证方法 */
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    this.$emit('close', true);
                    this.$message({
                        type: 'success',
                        message: '操作成功'
                    })
                } else {
                    console.log('error submit!!');
                    return false;
                }

            });
        }
    }

})




function deepClone(obj) {
    let objClone = Array.isArray(obj) ? [] : {};
    if (obj && typeof obj === "object") {
        for (key in obj) {
            if (obj.hasOwnProperty(key)) {
                //判断ojb子元素是否为对象，如果是，递归复制
                if (obj[key] && typeof obj[key] === "object") {
                    objClone[key] = deepClone(obj[key]);
                } else {
                    //如果不是，简单复制
                    objClone[key] = obj[key];
                }
            }
        }
    }
    return objClone;
}