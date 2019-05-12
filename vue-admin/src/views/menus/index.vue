<template>
    <el-row>
        <el-col :span="10">
            <el-tree :data="data" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
        </el-col>
        <el-col :span="14">
            <transition name="el-fade-in">
                <el-form
                    ref="ruleForm"
                    :model="form"
                    :rules="rules"
                    label-width="100px"
                    v-show="show"
                >
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="中文名称：" prop="titelZh">
                                <el-input v-model="form.titelZh" placeholder="中文名称，暂时没有验证"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="英文名称：" prop="titelEn">
                                <el-input v-model="form.titelEn" placeholder="英文名称，暂时没有验证"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-form-item label="路径：" prop="path">
                        <el-input v-model="form.path"></el-input>
                    </el-form-item>
                    <el-form-item label="状态：" prop="status">
                        <el-switch
                            v-model="form.status"
                            active-text="启用"
                            inactive-text="禁用"
                            active-value="1"
                            inactive-value="0"
                        ></el-switch>
                    </el-form-item>
                    <el-form-item label="权重：" prop="sort">
                        <el-input-number v-model="form.sort" :min="1" label="权重"></el-input-number>
                    </el-form-item>

                    <el-form-item label="组件路径：">
                        <el-input v-model="form.component" placeholder="跳转组件"></el-input>
                    </el-form-item>
                    <el-form-item label="图标：">
                        <el-input v-model="form.meta.icon" placeholder="跳转组件"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">立即创建</el-button>
                        <el-button>取消</el-button>
                    </el-form-item>
                </el-form>
            </transition>
        </el-col>
    </el-row>
</template>
<script>
export default {
    name: 'menus',
    data () {
        return {
            show: true,
            data: [{
                label: '一级 1',
                children: [{
                    label: '二级 1-1',
                    children: [{
                        label: '三级 1-1-1'
                    }]
                }]
            }],
            defaultProps: {
                children: 'children',
                label: 'label'
            },
            form: {
                title: {
                    zh: '',
                    en: ''
                },
                status: '1',
                sort: 1,
                meta: {
                    icon: ''
                }
            },
            rules: {
                titelZh: [{ required: true, message: '请输入菜单中文名称！', trigger: 'blur' }],
                titelEn: [{ required: true, message: '请输入菜单英文名称！', trigger: 'blur' }],
                path: [{ required: true, message: '请输入路径！', trigger: 'blur' }],
                status: [{ required: true, message: '请选择状态', }],
                sort: [{ required: true, message: '请输入输入权重' }],
            }
        };
    },
    created () {
        this.$http.get(`/egg/getMenus`).then(res => {
            console.log(res);
        }).catch(err => {

        })
    },
    methods: {
        handleNodeClick (data) {
        },
        onSubmit () {
            this.$refs.ruleForm.validate((valid) => {
                if (valid) {
                    this.$http.post(`/egg/addMenus`, this.form).then(res => {
                        console.log(res);
                    }).catch(err => {
                        console.log(err);
                    })
                } else {
                    return false;
                }
            });
        }

    }
}
</script>

